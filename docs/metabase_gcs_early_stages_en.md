# Data Platforms in Startups: The Build vs. Buy Dilemma (and a free deployment guide)

I bring you some reflections revolving around the concept of a **Data Platform**, focusing specifically on companies in their early stages of growth that are evaluating whether to implement a data architecture.

And given the unbreakable relationship between *"being and doing"* that my good friend Cheva invited me to reflect upon this weekend, we’ll wrap up this post with a concrete example of how to spin up a **Metabase** instance on **Google Cloud (GCP)** so you can start experimenting with the tool and see if it fits your needs.

## The Build vs. Buy Dilemma

When designing a data platform (though I suppose this applies to any software system), there is a constant tension between developing in-house solutions or paying for a managed service (SaaS). 

This debate is nothing new and goes back to the stone age (the classic *Build vs. Buy* dilemma). Naturally, each option has its pros and cons; the final decision will depend on multiple factors, including:
* Team size
* Available budget
* The complexity of the problem to be solved

### Advice from the Experts

When it comes to data, these options are usually evaluated against the company's or startup's maturity. For instance, Joe Reis and Matt Housley, in their book *Fundamentals of Data Engineering*, suggest that when a company is taking its first steps:

> *"Use off-the-shelf, turnkey solutions wherever possible. Build custom solutions and code only where this creates a competitive advantage"* (p. 38).

Later on, they also mention:

> *"Whenever possible, find the immutable technologies along the data engineering lifecycle, and use those as your base. Build transitory tools around the immutables"* (p. 212).

And they conclude:

> *"Investing in building and customizing when doing so will provide a competitive advantage for your business. Otherwise, stand on the shoulders of giants and use what’s already available in the market."* (p. 230).

All of this leads us to think that, for an organization in its early stages of growth, it's highly recommended to use existing, market-proven solutions instead of reinventing the wheel. Ideally, play it safe and focus on the *core* of the initiative. Perfect. I agree.

## Two Crucial Aspects for Founders

And this is where I want to catch your attention: my fellow founder, startuper, colleagues who met in grad school and are starting a business... It’s understandable that you need to focus on the product. Depending on the type of business, "data" (and its analytics) might or might not be a core component at this stage. 

However, there are two crucial aspects to keep in mind:

1. **The portability of your history:** Your product or service will evolve, change, transform, maybe die and be reborn. It is vital that, from a data perspective, you maintain the flexibility to jump in or out of the tools you choose and manage to preserve (or "migrate") your business's core analytics. That history will become an invaluable asset.
2. **Taking care of the budget:** I guess spending money on big-name tools can be useful for positioning... but watch your wallet, buddy! It's still a gamble; if you spend less on oversized infrastructure, you'll have more room to invest in more strategic areas or simply extend your project's runway.

## The Visualization Layer: Where to Save Money

So, if you are in charge of the data problem (notice I didn't even say "department") and you have to define the architecture, select the tools, and oversee the entire lifecycle of the data, you will inevitably have to deal with the **time/effort vs. money trade-off**. 

The most typical of operational dilemmas: *where will you spend more time, and where do you prefer or need to inject the cash?*

My not-so-humble recommendation is that, if you have to prioritize any phase of the cycle (generation, transformation, analytics, security, storage...), **the visualization layer is the one that should demand the least financial effort at this initial stage.**

Why? Because ultimately, visualization is a means to an end, not the end itself. If this month we managed to improve DAU/MAU by 13%, it makes absolutely no difference whether you show it in a dazzling presentation, an email thread, or with a dictator Mbappé meme on Slack.

On the other hand, BI-specific tools love to push you into the famous *vendor lock-in* (Tableau, Qlik, PowerBI, etc.). And while it's true that some of them are fantastic, they are not the only alternative; often you can achieve exactly the same thing using simpler and cheaper solutions.

## Why Metabase?

And this is where I take the opportunity to introduce my ideal candidate: **Metabase**.

It's an *open-source* data visualization platform that allows you to create dashboards and reports in an agile and intuitive way.

**What attracts me most to this tool?**
*   **Open Source:** No need to explain why.
*   **Dual flexibility:** It offers a super friendly *point-and-click* interface for business users, but seamlessly integrates the ability to write raw SQL queries when creating charts. If someone on the team wants to do some analytical magic, they have everything at their disposal to shine. Moreover, bringing your team closer to the raw data source fosters technical growth. As a *bonus track*, LLMs get along spectacularly well with generating SQL.
*   **Connectivity:** It integrates natively with multiple sources (PostgreSQL, MySQL, MongoDB, BigQuery, etc.).
*   **Built-in MCP:** It makes connecting with agents like Claude Code a breeze. That is, if you want to automate and burn tokens like a madman, you can do it without friction.
*   **Notifications:** This is a very specific thing, but I like it a lot. It allows you to set up alerts from charts with just a couple of clicks, providing operational capabilities on top of purely analytical ones.

**What am I not so convinced about?**
If you need your charts and dashboards to be version-controlled as code in a repository, you are forced to pay for the Pro version. Anyway, I forgive them; after all, they need to monetize the project somehow.

In summary: it’s a superb piece of software that perfectly fits the needs of an early-stage company.

## Metabase Architecture on GCP

To take action, I’m sharing a super simplified step-by-step guide to deploy your own Metabase instance in the Google Cloud ecosystem using Terraform.

The architectural design is as follows:

![Metabase Architecture on GCP](https://raw.githubusercontent.com/cacrespo/metabase-gcs/main/docs/architecture.jpg)

Here is the link to the repository with all the ready-to-use code: **[Metabase GCP Terraform Repository](https://github.com/cacrespo/metabase-gcs)**

With this, you can get it running in minutes and have something tangible to show. Inside the repository, I also included general guidelines (the *From POC to Production* section) just in case you need to scale the infrastructure robustly in the future.

## Conclusion

To wrap up, I return to the central dilemma: *in-house* development or paid SaaS? Obviously, every case is unique and requires proper analysis, heavily depending on the team's capabilities. 

I believe the key to tackling it is not falling into the temptation of turning this debate into a strict dichotomy (black or white). Today more than ever, we need to be creative in finding solutions (and also in formulating problems!). Besides, we have the invaluable support of smart parrots (LLMs) that never get tired of coding for us.

In the approach I present here, we are not deploying Kubernetes clusters or super complex architectures to maintain. In terms of operational costs, the impact is minimal, solidly resolving the primary visualization and analytical capacity needs. 

So, I leave you with an optimal balance between time invested and money spent. Take it and show it to whoever you need to. And by the way, you can keep your focus on what really matters: gaining traction on the *core* of the business.

---
*Disclaimer: This post is not sponsored by Google Cloud, Metabase, Cheva, or any of the tools mentioned.*
