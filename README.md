This document describes the architecture and functionality of an advanced Human Resources (HR) database system. 
The system is designed to successfully handle personnel information, job roles, departments, locations, and other critical HR data, 
easing day-to-day operations and giving useful insights for strategic decision-making.

Scope and Objectives

The HR database covers the following key areas:
> Employee management involves storing and managing extensive
employee data, such as personal information, contact information, job
titles, wage history, benefits, abilities, and performance evaluations.
> Job Responsibility Management: Establish and monitor job assignments,
duties, reporting structures, pay scales, and required skills.
> Departmental Structure: Maintain information on the organization's team
members, departments, locations, and reporting structures.
> Location Management: Keep track of the geographical data of the
company's offices and operations, such as addresses, maps, and regional
linkages.
> Dependent Details: Safely maintain and access information on employees’
dependents, their relationships with one another, and any applicable
benefits.
> Data Analysis and Reporting: Provide for complete analysis of data as well
as reporting on employee statistics, department performance, wage
trends, and other workforce indicators.

Relationship Details:
1:1 Relationships:
○ Employee to Jobs: One employee can only have one job.

1:M Relationships:
○ Region to Country: One region can have multiple countries
belonging to it.
○ Country to Location: One country can have several locations.
○ Location to Department: One location can be the address of
multiple departments.
○ Department to Employee: One department can work with several
employees.
○ Employee to Manager: One manager can oversee multiple
employees.
○ Employee to Dependent: One employee can have several
dependents linked to their record.

M:N Relationship:
○ Employee to Dependents: This many-to-many relationship exists
since an employee can have multiple dependents at different points
in their career, and a manager can be assigned to many employees
depending on the number of staff employed. This is implemented
through the "employee_dependents" junction table, which links
employee IDs with corresponding dependent IDs.

Table Descriptions:
> Regions: Stores unique identifiers and names of geographical regions
(e.g., North America, Europe, Asia).
> Countries: Captures country names and their corresponding region IDs,
establishing location hierarchy.
> Locations: Holds detailed address information, city, state/province, and
country ID for specific company office locations.
> Departments: Defines department names and links them to their
corresponding location IDs, indicating their physical placement.
> Jobs: Catalogs job titles, minimum and maximum salary ranges, and job
descriptions for various roles within the organization.
> Employees: Registers detailed employee information, including personal
details, contact information, job ID, salary history, benefits, manager ID,
department ID, and performance records.
> Dependents: Safely keeps personal information of employee dependents,
such as names, relationships, and relevant benefits they may be entitled
to.
> Employee_Dependents: This table acts as a bridge between the Employee
and Dependent entities, enabling the many-to-many relationship where
one employee can hold multiple dependents and one manager can be
assigned to multiple employees.
