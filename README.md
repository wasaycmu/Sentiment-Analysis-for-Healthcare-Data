# Sentiment-Analysis-for-Healthcare-Data

# Healthcare Analytics Case Study Using R

**Independent Study**  
**Professor:** Divakaran Liginlal  
**Institution:** Carnegie Mellon University in Qatar

## Overview

This project explores how publicly available data from [Meddy](https://www.meddy.co/)—a healthcare review platform in Qatar—can be leveraged using R to extract and analyze patient sentiment about doctors. The study aims to provide insights into the healthcare experience in Qatar without relying on traditional, resource-intensive survey methods.

---

## Objectives

- Extract doctor reviews and sentiments from Meddy.
- Use R for web scraping and data manipulation.
- Automate data collection across multiple doctor profiles.
- Perform sentiment analysis and generate visualizations.
- Explore the potential for scalable healthcare review analysis.

---

## Phase 1: Data Collection via Web Scraping

### Tools & Libraries Used

- `rvest`: For HTML parsing and scraping.
- `SelectorGadget`: For identifying CSS selectors.
- `csv`: For storing extracted data.

### Key Steps

- Scrape doctor names, reviews, and patient sentiments (emoticons).
- Use `.comment-body`, `.comment-name`, and other CSS selectors to locate relevant data.
- Store the scraped data in structured CSV files.
- Generate pie charts from sentiment counts using base R plotting.

### Automation Logic

- Start from a specialty URL (e.g., General Practitioners).
- Extract doctor profile URLs.
- Iterate through each URL to:
  - Collect comments and sentiments.
  - Save data into CSVs named after each doctor.
  - Generate pie charts of sentiment breakdown (Positive, Neutral, Negative).

---

## Phase 2: Sentiment Analysis & Text Mining

### Tools & Libraries Used

- `tm`, `SnowballC`: Text preprocessing and stemming.
- `wordcloud`: For generating word clouds.
- `syuzhet`: For NRC sentiment classification.
- `ggplot2`: For sentiment distribution bar charts.

### Key Steps

- Load scraped comments into an R corpus.
- Clean and preprocess the text:
  - Lowercasing, removing numbers/punctuation/stopwords, stemming.
- Generate a word cloud for keyword trends.
- Use `get_nrc_sentiment()` to extract emotional tone.
- Visualize emotion counts (e.g., anger, joy, trust) via bar charts.

---

## Sample Outputs

- Pie charts representing doctor-specific sentiment ratios.
- Word clouds showing commonly used patient terms.
- Bar graphs summarizing emotional distribution across reviews.

---

## Scalability & Adaptability

- Easily extendable to other websites with consistent HTML structures.
- Works with any CSS-structured web platform with public reviews.
- Could be adapted for automated voice-to-text sentiment capture in the future using NLP pipelines.

---

## Directory Structure

```plaintext
.
├── scripts/
│   ├── scrape_doctor_names.R
│   ├── scrape_single_doctor.R
│   ├── scrape_multiple_doctors.R
│   ├── sentiment_analysis_single.R
│   └── sentiment_analysis_multiple.R
├── data/
│   ├── link.csv
│   ├── docname.csv
│   └── *.csv (individual doctor review files)
├── outputs/
│   ├── WordCloud.png
│   └── SentimentBarGraph.png
└── README.md
```
## Limitations
 - Dependent on Meddy’s HTML structure; breaking changes to the site may break scraping scripts.
 - Rate-limiting may occur; number of profiles scraped was restricted for this study.
 - Emoticon-based sentiment lacks granularity; supplementing with NLP improves accuracy.

## Future Work
 - Integrate voice input and automated review analysis via NLP.
 - Expand to include other data sources and healthcare systems.
 - Develop an interactive dashboard for live sentiment tracking.
