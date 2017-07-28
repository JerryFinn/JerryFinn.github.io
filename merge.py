# -*- coding: utf-8 -*-
"""
Created on Fri Jul  7 20:44:17 2017

@author: finnjj
"""

import pandas as pd
import numpy as np
from pandas import DataFrame, Series

df_di_st = pd.read_csv('ssdi.st.csv')
df_di_co = pd.read_csv('ssdi.co.csv', encoding='iso-8859-1')

df_emp_st = pd.read_csv('employment.st.csv')
df_emp_co = pd.read_csv('employment.co.csv')

df_county = pd.merge(df_di_co, df_emp_co, how='inner', on=['Year', 'State', 'State.Code', 'County', 'County.Code'])
df_state = pd.merge(df_di_st, df_emp_st, how='inner', on=['Year', 'State', 'State.Code'])

df_state['DisabilityRate'] = df_state['Disabled.Workers'] / df_state['Total.Labor']
df_county.rename(index=str, columns={"State.Code" : "StateCode",  "County.Code" : "CountyCode", "Disabled.Workers" : "DisabledWorkers", "Total.Labor" : "TotalLabor", "Uemployment.Rate" : "UnemploymentRate"}, inplace=True)                      
df_state.rename(index=str, columns={"State.Code" : "StateCode",  "Disabled.Workers" : "DisabledWorkers", "Total.Labor" : "TotalLabor", "Uemployment.Rate" : "UnemploymentRate"}, inplace=True)

df_county.dropna(inplace=True)
df_state.dropna(inplace=True)

df_county.to_csv('js_county.csv', index=False, float_format='%.3f')
df_state.to_csv('js_state.csv', index=False, float_format='%.3f')
