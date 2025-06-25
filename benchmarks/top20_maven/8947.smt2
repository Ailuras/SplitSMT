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

(declare-sort var2656 0)
(declare-sort var2311 0)
(declare-sort var2094 0)
(declare-sort var1363 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getQuery/-116703388 (var2656) String)
(declare-fun var2094_sort/-2094180924 ((Array Int var1363)) void)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1363__ ((Array Int String)) (Array Int var1363))
(declare-const null-var2656 var2656)
(declare-const null-String String)
(declare-const var1430 var2656) ; Statement: r0 := @parameter0: java.net.URL 
(assert (not (= var1430 null-var2656)))
(assert true)
(define-const var2362 String (getQuery/-116703388 var1430)) ; Statement: $r1 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>() 
 ; Statement: if $r1 != null goto $r3 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>() 
(assert (not (not (= var2362 null-String)))) ; Negate: Cond: $r1 != null  
(define-const var3295 String "") ; Statement: $r3 = "" 
 ; Statement: goto [?= $r2 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("&")] 
(assert true) ; Non Conditional
; split operation: var3653 = var3295.split("&") ; Statement: $r2 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("&") 
;(assert (var2094_sort/-2094180924 (cast-from-__Array__Int__String__-to-__Array__Int__var1363__ var3653))) ; Statement: staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>($r2) 

(declare-const var3653!1 (Array Int String))
 ; Statement: return $r2 
(check-sat)
; {getQuery/-116703388=([java.net.URL], java.lang.String), var2094_sort/-2094180924=([java.lang.Object[]], void), cast-from-__Array__Int__String__-to-__Array__Int__var1363__=([java.lang.String[]], java.lang.Object[])}
; {var2656=java.net.URL, var1430=r0, var2362=$r1, var2311=null_type, var3295=$r3, var3653=$r2, var2094=java.util.Arrays, var1363=java.lang.Object}
; {java.net.URL=var2656, r0=var1430, $r1=var2362, null_type=var2311, $r3=var3295, $r2=var3653, java.util.Arrays=var2094, java.lang.Object=var1363}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.URL;	$r1 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>();	if $r1 != null goto $r3 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>();	$r3 = "";	goto [?= $r2 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("&")];	$r2 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("&");	staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>($r2);	return $r2
;block_num 3