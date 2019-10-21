select dra.dra_id as "Nr.", ge.gen_name as "Genre", dra.dra_name as "Name des Stücks", concat_ws(' ', per.per_vName, per.per_nName) as "Autor", drev.eve_termin as "Erstaufführung"  from drama dra 
left outer join genre ge
on dra.gen_id = ge.gen_id
left outer join dramaevent drev
on dra.dra_id = drev.dra_id
left outer join crew cre
on cre.eve_id = drev.eve_id
left outer join person per
on per.per_id = cre.per_id
left outer join rolle ro
on per.rol_id = ro.rol_id
group by dra.autor_id, drev.eve_termin;

select dra.dra_id as "Nr.", ge.gen_name as "Genre", dra.dra_name as "Name des Stücks", concat_ws(' ', per.per_vName, per.per_nName) as "Autor", drev.eve_termin as "Erstaufführung"  from drama dra 
left outer join genre ge
on dra.gen_id = ge.gen_id
left outer join dramaevent drev
on dra.dra_id = drev.dra_id
left outer join person per
on dra.autor_id = per.per_id
group by dra.dra_name
order by dra_id;


select dra.dra_name as "Drama", ge.gen_name as "Genre", concat_ws(' ', per.per_vName, per.per_nName) as "Autor", drev.eve_termin as "Erstaufführung" from drama dra 
left outer join genre ge
on dra.gen_id = ge.gen_id
left outer join dramaevent drev
on dra.dra_id = drev.dra_id
left outer join person per
on dra.autor_id = per.per_id
where dra.dra_name like '%test%';