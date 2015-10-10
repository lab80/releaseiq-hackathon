@IQ or= {}

Posts.attachSchema(new SimpleSchema(
  aggregateCost:
    type: Number
    decimal: true
  aggregateBenefit:
    type: Number
    decimal: true
  costEstimates:
    type: [Object]
    blackbox: true
    optional: true
  benefitEstimates:
    type: [Object]
    blackbox: true
    optional: true
))

ESTIMATES_TO_AGGREGATES =
  costEstimates: 'aggregateCost'
  benefitEstimates: 'aggregateBenefit'

IQ.score = (collection, costOrBenefit, itemId, score) ->
  user = Meteor.user()
  if (!user || !Users.can.vote(user, true))
    throw new Error("not allowed!!")

  item = collection.findOne(itemId)
  votePower = getVotePower(user)
  result = collection.update(
    {_id: item && item._id, "#{costOrBenefit}.userId": user._id},
    {$set:
      "#{costOrBenefit}.$.score": score
      "#{costOrBenefit}.$.votePower": votePower
    },
    validate: false
  )
  if not result
    result = collection.update(
      {_id: item && item._id},
      {$push:
        {"#{costOrBenefit}":
          userId: user._id
          score: score
          votePower: votePower
        }
      },
      validate: false
    )

  costOrBenefits = collection.findOne(itemId, {fields: {"#{costOrBenefit}": 1}})[costOrBenefit]
  scores = _.pluck(costOrBenefits, 'score')
  votePowers = _.pluck(costOrBenefits, 'votePower')
  aggregatedScore = _.reduce(_.zip(scores, votePowers), ((memo, pair) -> memo + pair[0]*pair[1]), 0)
  result = collection.update(
    {_id: item && item._id},
    {$set: {"#{ESTIMATES_TO_AGGREGATES[costOrBenefit]}": aggregatedScore}}
  )

Meteor.methods(
  estimateCost: (postId, score) ->
    IQ.score(Posts, "costEstimates", postId, score)
  estimateBenefit: (postId, score) ->
    IQ.score(Posts, "benefitEstimates", postId, score)
  clearPost: (postId) ->
    #FIXME: remove this!!
    Posts.update({_id: postId}, {$unset: {costEstimates: null, benefitEstimates: null}}, {validate: false})
)
