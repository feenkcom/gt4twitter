# gt4twitter

This project provides support for exploring Twitter data from Glamorous Toolkit. 

This is still a work-in-progress only partially implementing the Twitter API and user data import.

### Loading 

To load the project execute the code below in a Pharo snippet.

```
Metacello new
    repository: 'github://feenkcom/gt4twitter:main';
    baseline: #GToolkit4Twitter;
    load.

#BaselineOfGToolkit4Twitter asClass loadLepiter.
```

### Getting Started

This projects provides two ways of exploring Twitter data:
- *Twitter API*: data can be obtained from Twitter using their API;
- *Twitter Export*: users can download from Twitter an archive containing their data.

All documentation is available after loading the project in the *"Twitter Data"* knowledge base. You can open spotter and search for *"Twitter Data"*.
