{{
    config(
        materialized='table', 
        database="DEV_EDW",
		transient=false,
        schema="DBT_SRINI"
    )
}}

SELECT
	MTIMESERIES.METER_NUMBER_INDEX,
	MTIMESERIES.MEASUREMENT_DAY,
	MTIMESERIES.PRODUCT_INDEX,
	CLASS_RELATIONSHIP_IDX,
	MTIMESERIES.MEASUREMENT_MONTH,
	REP.GAS_DATE as MEASUREMENT_DATE,
	MTIMESERIES.EFFECTIVE_DATE as VOL_EFFECTIVE_DATE,
	MTIMESERIES.EFFECTIVE_END_DATE as VOL_EFFECTIVE_END_DATE,
	MTIMESERIES.GMS_DATE,
	MTIMESERIES.PRESSURE,
	MTIMESERIES.GAUGE_PRESSURE ,
	MTIMESERIES.ABSOLUTE_PRESSURE,
	MTIMESERIES.DIFFERENTIAL_PRESSURE,
	MTIMESERIES.TEMPERATURE,
	MTIMESERIES.FLOW_DURATION,
	MTIMESERIES.ADJUSTED_TOTAL_ENERGY,
	MTIMESERIES.ADJUSTED_TOTAL_VOLUME,
	MTIMESERIES.ROLLED_ADJUSTED_TOTAL_ENERGY,
	MTIMESERIES.ROLLED_ADJUSTED_TOTAL_VOLUME,
	MTIMESERIES.MEASURED_ENERGY,
	MTIMESERIES.MEASURED_HEAT_VALUE,
	MTIMESERIES.MEASURED_VOLUME,
	MTIMESERIES.MEASURED_VOLUME_SATF,
	MTIMESERIES.PROJECTED_ENERGY,
	MTIMESERIES.PROJECTED_VOLUME,
	MTIMESERIES.AUTOESTIMATED,
	MTIMESERIES.BTU_BASE,
	MTIMESERIES.C1,
	MTIMESERIES.C2, 
	MTIMESERIES.C3,
	MTIMESERIES.ISO_C4,
	MTIMESERIES.N_C4,
	MTIMESERIES.ISO_C5,
	MTIMESERIES.N_C5,
	MTIMESERIES.NEO_C5,
	MTIMESERIES.C6,
	MTIMESERIES.C7,
	MTIMESERIES.C8,
	MTIMESERIES.C9,
	MTIMESERIES.C10,
	MTIMESERIES.CO,
	MTIMESERIES.CO2,
	MTIMESERIES.H2,
	MTIMESERIES.H2O,
	MTIMESERIES.H2S,
	MTIMESERIES.HE,
	MTIMESERIES.N2,
	MTIMESERIES.O2,
	MTIMESERIES.COMPLETION_STATUS,
	MTIMESERIES.CURRENT_PERIOD_ADJUSTMENT,
	MTIMESERIES.DURATION,
	MTIMESERIES.EDITED,
	MTIMESERIES.EXCEPTION_COUNT,
	MTIMESERIES.GPA_2172_APPLY,
	MTIMESERIES.HAS_EDITS,
	MTIMESERIES.HAS_ESTIMATES,
	MTIMESERIES.HAS_EVENTS,
	MTIMESERIES.PRIOR_PERIOD_ADJ_ENERGY,
	MTIMESERIES.PRIOR_PERIOD_ADJUSTMENT,
	MTIMESERIES.SPECIFIC_GRAVITY,
	MTIMESERIES.AR, 
	MTIMESERIES.HEATING_VALUE_AS_DELIV, 
	MTIMESERIES.HEATING_VALUE_DRY, 
	MTIMESERIES.HEATING_VALUE_WET, 
	MTIMESERIES.GPA_2172_SPEC_GRAVITY, 
	GPA_2172_GAS_SAT_COND,
	GPA_2172_VOL_SAT_COND,
	GROSS_WOBBE_INDEX,
	MTIMESERIES.HYDROCARBON_DEWPOINT,
	LAB_DATE,
	MTIMESERIES.PRESSURE_BASE,
	MTIMESERIES.PULSES, 
	SAMPLE_DATE,
	SAMPLE_TYPE,
	MTIMESERIES.SP_HEAT_RATIO, 
	MTIMESERIES.VISCOSITY, 
	MTIMESERIES.TIME_STAMP
	      FROM 
    {{ source('dbt_volumes_source', 'FC_METER') }} METER
      LEFT OUTER  JOIN {{ source('dbt_volumes_source', 'FC_FFMTR_DAILY') }} MTIMESERIES ON METER.METER_NUMBER_INDEX = MTIMESERIES.METER_NUMBER_INDEX
      LEFT JOIN {{ source('dbt_volumes_calender', 'REP_CALENDAR_DATES') }} REP ON  REP.MEASUREMENT_DAY = MTIMESERIES.MEASUREMENT_DAY
      WHERE MTIMESERIES.PRODUCT_INDEX = 0 AND CLASS_RELATIONSHIP_IDX = 0
      and REP.GAS_DATE between DATEADD(Day ,-365, current_date) and current_date