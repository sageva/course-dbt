### *PART 2: Modeling Challenge*

The project asks for models to address two questions: 
- How are our users moving through the product funnel?
- Which steps in the funnel have largest drop off points?

I created two models to address this: int_product_funnel and fact_product_funnel, both in the core mart. The int model unions together each step of the product funnel and assigns a funnel step to each session id. The fact model takes the int model and returns the last step a session made it to, along with corresponding information about the session (the user, the product, the page url, etc.). With those models, we can answer the two questions above. In terms of specific answers; the questions are rather vague and I'd want to get more clarity about what folks are looking to answer, I purposefully included a lot of information in the fact model so that it could be flexible and answer a number of different questions. At a high-level, can see; the majority ofseessions do make it to a checkout, and it's about an equal number of sessions that fall off at the prior points, with a mix of products and users and pages that could be contirbuting to fall off. 

### *PART 3A:*

My organization is considering setting up a dbt instance along with our current Airflow instance and Tableau reporting dashboards. Right now, we do a lot of transformation within Redshift or via Python as part of Airflow jobs, and we're pretty light on documentation/replicability/accessibility. Our data sets often require joining together multiple sources, converting types and re-grouping, etc. I and others on my team have pitched the value of dbt as letting us more efficiently transform data all in Redshift while still leveraging Python-esque data transformation capabilities; creating much clearer documentation, acceessiblity and lower training barriers for our data pipelines outside of the current small group of users on the data team able to contribute; and allow a lot more code-sharing and replicability, especially because it's common in our space to have folks who join us just for our busy season and we struggle to document/re-use their code after they are gone. 

As of now, we're moving forward with using dbt for some small jobs; depending on how that goes, we'll start transitioning our bigger jobs over. We have a busy period organizationally starting in Aug-Nov., so there's a limit to how much change we can do before then.
