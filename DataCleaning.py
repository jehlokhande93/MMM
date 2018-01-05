
# coding: utf-8

# In[1]:


import pandas as pd
original_data = pd.read_csv("data.csv",sep=',',encoding='latin-1')


# In[2]:


data = original_data.copy()


# In[3]:


original_data


# In[4]:


del data['Business Unit']
del data['CUC Descr']
del data['Market']
del data['Type of Product']
del data['Cosmetic grouping OT']
del data['Way of sale']
del data['REAL PUP']
del data['Exposed Tones']
del data['Bulk Photo']
del data['Product Photo']
del data['Year']
del data['Campaign']
del data['Brand']


# In[5]:


#data.to_csv("data_reduced.csv",header=True, index=False)


# In[58]:

#Rename columns and select only revelant offer types. This was decided after discussions with Belcorp
offer_type_list = [3,11,13,14,15,17,29,35,36,48,106,123]
cuc_code_list = [200012014,200051232,200039855,200044715,200037781]
data = data.rename(columns={"Ofert type":"Offer type"})
data = data[(data['Offer type'].isin(offer_type_list))&(data['CUC Code'].isin(cuc_code_list))]


# In[59]:


usd_data = data.copy()
usd_data["Discount"] = usd_data["% Discount Catalog"] + usd_data["% Discount Demo"]
del usd_data['Regular Price Local Currency']
del usd_data["Sale Price Local Currency"]
del usd_data["% Discount Catalog"]
del usd_data["% Discount Demo"]
usd_data = usd_data[(usd_data['Real Demanded units']>=100)&(usd_data['Regular Price USD']>1)&(usd_data['Sale Price USD']>0)]
usd_data.to_csv("usd_data.csv",header=True, index=False)


# In[60]:


usd_data


# In[61]:


data


# In[62]:


del data['Regular Price USD']
del data['Sale Price USD']


# In[63]:

##Choose rows only where the below constraints are satisfied.
filtered_data = data[(data['Real Demanded units']>=100)&(data['Regular Price Local Currency']>1)&(data['Sale Price Local Currency']>0)]


# In[64]:


filtered_data


# In[65]:

#Combine the discount columns
filtered_data["Discount"] = filtered_data["% Discount Catalog"] + filtered_data["% Discount Demo"]


# In[66]:

#Remove the seperate discount columns
del filtered_data["% Discount Catalog"]
del filtered_data["% Discount Demo"]


# In[67]:

#Save the intermediate files for analysis
data.to_csv("data_reduced.csv",header=True, index=False)
filtered_data.to_csv("data_reduced&filtered.csv", header=True, index=False)


# In[68]:


data = filtered_data


# In[69]:

##Save the countr-product files to further analysis
#200012014
CO03_200012014 = data[(data['CUC Code']==200012014)&(data['Center']=='CO03')]
CO03_200012014.to_csv("CO03_200012014.csv",header=True, index=False)
MX03_200012014 = data[(data['CUC Code']==200012014)&(data['Center']=='MX03')]
MX03_200012014.to_csv("MX03_200012014.csv",header=True, index=False)
PE03_200012014 = data[(data['CUC Code']==200012014)&(data['Center']=='PE03')]
PE03_200012014.to_csv("PE03_200012014.csv",header=True, index=False)


# In[70]:


#200051232
CO03_200051232 = data[(data['CUC Code']==200051232)&(data['Center']=='CO03')]
CO03_200051232.to_csv("CO03_200051232.csv",header=True, index=False)
MX03_200051232 = data[(data['CUC Code']==200051232)&(data['Center']=='MX03')]
MX03_200051232.to_csv("MX03_200051232.csv",header=True, index=False)
PE03_200051232 = data[(data['CUC Code']==200051232)&(data['Center']=='PE03')]
PE03_200051232.to_csv("PE03_200051232.csv",header=True, index=False)


# In[71]:


#200039855
CO03_200039855 = data[(data['CUC Code']==200039855)&(data['Center']=='CO03')]
CO03_200039855.to_csv("CO03_200039855.csv",header=True, index=False)
MX03_200039855 = data[(data['CUC Code']==200039855)&(data['Center']=='MX03')]
MX03_200039855.to_csv("MX03_200039855.csv",header=True, index=False)
PE03_200039855 = data[(data['CUC Code']==200039855)&(data['Center']=='PE03')]
PE03_200039855.to_csv("PE03_200039855.csv",header=True, index=False)


# In[72]:


#200044715
CO03_200044715 = data[(data['CUC Code']==200044715)&(data['Center']=='CO03')]
CO03_200044715.to_csv("CO03_200044715.csv",header=True, index=False)
MX03_200044715 = data[(data['CUC Code']==200044715)&(data['Center']=='MX03')]
MX03_200044715.to_csv("MX03_200044715.csv",header=True, index=False)
PE03_200044715 = data[(data['CUC Code']==200044715)&(data['Center']=='PE03')]
PE03_200044715.to_csv("PE03_200044715.csv",header=True, index=False)


# In[73]:


#200037781
CO03_200037781 = data[(data['CUC Code']==200037781)&(data['Center']=='CO03')]
CO03_200037781.to_csv("CO03_200037781.csv",header=True, index=False)
MX03_200037781 = data[(data['CUC Code']==200037781)&(data['Center']=='MX03')]
MX03_200037781.to_csv("MX03_200037781.csv",header=True, index=False)
PE03_200037781 = data[(data['CUC Code']==200037781)&(data['Center']=='PE03')]
PE03_200037781.to_csv("PE03_200037781.csv",header=True, index=False)


# In[74]:


CO03 = data[data['Center']=='CO03']
CO03.to_csv("CO03.csv",header=True,index=False)
MX03 = data[data['Center']=='MX03']
MX03.to_csv("MX03.csv",header=True,index=False)
PE03 = data[data['Center']=='PE03']
PE03.to_csv("PE03.csv",header=True,index=False)


# In[77]:


P_200012014 = usd_data[(usd_data['CUC Code']==200012014)]
P_200037781 = usd_data[(usd_data['CUC Code']==200037781)]
P_200037781.to_csv("P_200037781.csv",header=True,index=False)

