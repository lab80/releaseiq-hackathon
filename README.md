# ReleaseIQ

ReleaseIQ - 2015 Meteor hackathon

## Motivation

> Release Planning Should Be an Event for the Whole Community!

Many successful startups like Product Hunt choose to build their product in public, roping in their user community. The transparency and sense of participation is crucial in building an engaged community of early adopters.

We're building a service called Hello Money by actively inviting Redditors to discuss our product and submit feature requests via AMA and comments. We want to take this approach further and really opt our users in our development process.

To be honest, engaging the community in the development process is something that we want the Meteor HQ to do better too. So you can say this hackathon submission itself is our request for the Meteor team to become more open.

## Features
- **Users** are able to request and discuss product features and improvements.
- Once **builders** announce release planning event, **users** and **builders** collaboratively vote on feature candidates.
- **Builders** can perform a cost-benefit analysis to select features, and announce the new release plan to the **users**.

## Benefit
- **Users** can more actively voice their desires.
- **Builders** can develop in the direction that makes their audience happy.
- The entire process is **public**, well-documented, and notifications keep the community **engaged**.
- Builders can create many opportunities for **growth hack** and viral marketing along the process: Encourage friends to vote via Twitter, Periscope/Meerkat event for vote events, etc.

## Demo

We made a demo video: http://releaseiq.com/video
We also have a live demo: http://releaseiq.com

## Setting it up

We didn't have time to package this during the 24 hour hackathon. However, it
should work ok out of the box:

```
$ git clone git@github.com:lab80/releaseiq.git
$ cd releaseiq
$ meteor
$ open http://localhost:3000
```

There will be some dummy data loaded by default, and you can register as a user
to vote on issues. In order to become a "builder", you need to do the following
magic in a different shell, assuming you are the only user:

```
$ cd releaseiq
$ meteor shell
> Users.updateAdmin(Users.findOne()._id, true)
```
