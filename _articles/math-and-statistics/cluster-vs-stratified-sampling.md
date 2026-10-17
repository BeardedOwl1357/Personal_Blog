---
title: "Cluster vs Stratified sampling"
domain: "Math and Statistics"
topic: "Cluster vs Stratified sampling"
category: "Statistics"
description: "Sampling is the process of selecting a subset of a population to draw conclusions about the whole. It saves time, cost, and effort while making research practical. The key methods include stratified sampling, which takes samples from every group; cluster sampling, which studies selected groups; and multi-stage sampling, which selects samples in multiple steps, from larger groups to smaller units."
permalink: /math-and-statistics/cluster-vs-stratified-sampling/
---

# Cluster vs Stratified sampling

## Definition / Formula

Sampling is the process of selecting a subset of a population to draw conclusions about the whole. It saves time, cost, and effort while making research practical. The key methods include stratified sampling, which takes samples from every group; cluster sampling, which studies selected groups; and multi-stage sampling, which selects samples in multiple steps, from larger groups to smaller units.

## Explanation

Cluster sampling and stratified sampling differ mainly in what you select and why you select it. In stratified sampling, you divide the population into groups and sample from every group, while in cluster sampling, you divide the population into groups and select only some groups for study.

Imagine XLRI has 1,000 students across different programs and years. You want to survey students about campus life, so you need a way to select a manageable sample.

### Stratified sampling
Take some students from every group. Divide the students into **strata**, such as `BM (Business Management)`, `HRM (Human Resource Management)`, and other programs, then randomly select students from each group. This ensures every program is represented in your sample.

```mermaid

flowchart TD
    A["All MBA Students"] --> B["BM"]
    A --> C["HRM"]
    A --> D["Other Programs"]

    B --> E["Randomly Select Students"]
    C --> F["Randomly Select Students"]
    D --> G["Randomly Select Students"]

    E --> H["Final Sample"]
    F --> H
    G --> H

    classDef group fill:#DCEBFA,stroke:#3973AC,color:#163A5C
    classDef result fill:#DDF3E4,stroke:#39845A,color:#174D2D
    class B,C,D,E,F,G group
    class H result

```


### Cluster sampling
Divide the students into clusters, such as year (first year or second year), sections etc. You survey students in those selected sections rather than sampling from every section. Ideally, each cluster reflects the wider population. 

```mermaid
flowchart TD
    A["All MBA Students"] --> B["Section 1"]
    A --> C["Section 2"]
    A --> D["Section 3"]
    A --> E["Section 4"]

    B --> F["Selected"]
    D --> F

    F --> G["Survey All Students in Selected Sections"]
    G --> H["Final Sample"]

    classDef group fill:#DCEBFA,stroke:#3973AC,color:#163A5C
    classDef selected fill:#FBE7C6,stroke:#B7791F,color:#704214
    classDef result fill:#DDF3E4,stroke:#39845A,color:#174D2D
    class B,C,D,E group
    class F,G selected
    class H result
```

### Summary of these methods

| Basis          | Stratified sampling                         | Cluster sampling                                    |
| -------------- | ------------------------------------------- | --------------------------------------------------- |
| Selection      | Some members from every stratum             | Some clusters from the population                   |
| Groups         | Similar members within each stratum         | Ideally, each cluster reflects the wider population |
| Main objective | Ensure representation and improve precision | Reduce cost and effort                              |
| Example        | Students sampled from every program         | A few tutorial sections selected                    |

> [!tip]
> Stratified means all groups represented; cluster means some groups selected

### Cluster Sampling Iteratively
After creating clusters, we can further create clusters to pinpoint the criteria of people we need. Imagine you want to survey MBA students across India, but you cannot visit every college, so you randomly select 3 states, then 4 colleges in each state, then 2 classes in each college, and finally 10 students from each class. You have selected your sample through four stages, giving you \(3 \times 4 \times 2 \times 10 = 240\) students.

```mermaid

flowchart TD
    A["MBA Students Across India"]
    A --> B["Stage 1: Select 3 States"]
    B --> C["Stage 2: Select 4 Colleges per State"]
    C --> D["Stage 3: Select 2 Classes per College"]
    D --> E["Stage 4: Select 10 Students per Class"]
    E --> F["Final Sample: 240 Students"]

    style A fill:#E5E7EB,stroke:#6B7280,color:#111827
    style B fill:#DBEAFE,stroke:#2563EB,color:#1E3A8A
    style C fill:#D1FAE5,stroke:#059669,color:#064E3B
    style D fill:#FEF3C7,stroke:#D97706,color:#78350F
    style E fill:#F3E8FF,stroke:#9333EA,color:#581C87
    style F fill:#DCFCE7,stroke:#16A34A,color:#14532D
```
