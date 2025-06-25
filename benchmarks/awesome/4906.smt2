(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1646 0)
(declare-sort var1195 0)
(declare-sort var1648 0)
(declare-sort var2698 0)
(declare-sort var292 0)
(declare-sort var3404 0)
(declare-sort var645 0)
(declare-sort var1032 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2698_newHashSet/99871946 () var1648)
(declare-fun containsKey/-591989699 (var1646 var292) Bool)
(declare-fun cast-from-String-to-var292 (String) var292)
(declare-fun getProperty/1391780669 (var1646 String) String)
(declare-fun var645_asList/1779083644 ((Array Int var292)) var3404)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var292__ ((Array Int String)) (Array Int var292))
(declare-fun var1648_addAll/-907809033 (var1648 var1032) Bool)
(declare-fun cast-from-var3404-to-var1032 (var3404) var1032)
(declare-const null-var1646 var1646)
(declare-const null-String String)
(declare-const var2225 var1646) ; Statement: r2 := @parameter0: java.util.Properties 
(assert (not (= var2225 null-var1646)))
(declare-const var263 String) ; Statement: r7 := @parameter1: java.lang.String 
(assert (not (= var263 null-String)))
(declare-const var568 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var568 null-String)))
(define-const var2157 var1648 var2698_newHashSet/99871946) ; Statement: r0 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet()>() 
(define-const var43 String var568) ; Statement: r15 = r1 
(assert true)
(define-const var2023 Bool (containsKey/-591989699 var2225 (cast-from-String-to-var292 var568))) ; Statement: $z0 = virtualinvoke r2.<java.util.Properties: boolean containsKey(java.lang.Object)>(r1) 
 ; Statement: if $z0 != 0 goto $z1 = virtualinvoke r2.<java.util.Properties: boolean containsKey(java.lang.Object)>(r15) 
(assert (not (= (ite var2023 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var2329 Bool (containsKey/-591989699 var2225 (cast-from-String-to-var292 var43))) ; Statement: $z1 = virtualinvoke r2.<java.util.Properties: boolean containsKey(java.lang.Object)>(r15) 
 ; Statement: if $z1 == 0 goto return r0 
(assert (not (= (ite var2329 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var113 String (getProperty/1391780669 var2225 var43)) ; Statement: $r3 = virtualinvoke r2.<java.util.Properties: java.lang.String getProperty(java.lang.String)>(r15) 
; split operation: var2704 = var113.split(",") ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var270 var3404 (var645_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var292__ var2704))) ; Statement: $r5 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r4) 
;(assert (var1648_addAll/-907809033 var2157 (cast-from-var3404-to-var1032 var270))) ; Statement: interfaceinvoke r0.<java.util.Set: boolean addAll(java.util.Collection)>($r5) 

(declare-const var2157!1 var1648)
(declare-const var270!1 var3404)
(assert true) ; Non Conditional
 ; Statement: return r0 
(check-sat)
; {var2698_newHashSet/99871946=([], java.util.Set), containsKey/-591989699=([java.util.Properties, java.lang.Object], boolean), cast-from-String-to-var292=([java.lang.String], java.lang.Object), getProperty/1391780669=([java.util.Properties, java.lang.String], java.lang.String), var645_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var292__=([java.lang.String[]], java.lang.Object[]), var1648_addAll/-907809033=([java.util.Set, java.util.Collection], boolean), cast-from-var3404-to-var1032=([java.util.List], java.util.Collection)}
; {var1646=java.util.Properties, var2225=r2, var263=r7, var1195=null_type, var568=r1, var1648=java.util.Set, var2698=edu.stanford.nlp.util.Generics, var2157=r0, var43=r15, var292=java.lang.Object, var2023=$z0, var2329=$z1, var113=$r3, var2704=$r4, var3404=java.util.List, var645=java.util.Arrays, var270=$r5, var1032=java.util.Collection}
; {java.util.Properties=var1646, r2=var2225, r7=var263, null_type=var1195, r1=var568, java.util.Set=var1648, edu.stanford.nlp.util.Generics=var2698, r0=var2157, r15=var43, java.lang.Object=var292, $z0=var2023, $z1=var2329, $r3=var113, $r4=var2704, java.util.List=var3404, java.util.Arrays=var645, $r5=var270, java.util.Collection=var1032}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @parameter0: java.util.Properties;	r7 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	r0 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet()>();	r15 = r1;	$z0 = virtualinvoke r2.<java.util.Properties: boolean containsKey(java.lang.Object)>(r1);	if $z0 != 0 goto $z1 = virtualinvoke r2.<java.util.Properties: boolean containsKey(java.lang.Object)>(r15);	$z1 = virtualinvoke r2.<java.util.Properties: boolean containsKey(java.lang.Object)>(r15);	if $z1 == 0 goto return r0;	$r3 = virtualinvoke r2.<java.util.Properties: java.lang.String getProperty(java.lang.String)>(r15);	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r5 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r4);	interfaceinvoke r0.<java.util.Set: boolean addAll(java.util.Collection)>($r5);	return r0
;block_num 4