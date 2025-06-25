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

(declare-sort var2701 0)
(declare-sort var1473 0)
(declare-sort var1958 0)
(declare-sort var2696 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getQuery/-116703388 (var2701) String)
(declare-fun var1958_sort/-2094180924 ((Array Int var2696)) void)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2696__ ((Array Int String)) (Array Int var2696))
(declare-const null-var2701 var2701)
(declare-const null-String String)
(declare-const var2186 var2701) ; Statement: r0 := @parameter0: java.net.URL 
(assert (not (= var2186 null-var2701)))
(assert true)
(define-const var282 String (getQuery/-116703388 var2186)) ; Statement: $r1 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>() 
 ; Statement: if $r1 != null goto $r3 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>() 
(assert (not (= var282 null-String))) ; Cond: $r1 != null 
(assert true)
(define-const var2872 String (getQuery/-116703388 var2186)) ; Statement: $r3 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>() 
(assert true) ; Non Conditional
; split operation: var1805 = var2872.split("&") ; Statement: $r2 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("&") 
;(assert (var1958_sort/-2094180924 (cast-from-__Array__Int__String__-to-__Array__Int__var2696__ var1805))) ; Statement: staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>($r2) 

(declare-const var1805!1 (Array Int String))
 ; Statement: return $r2 
(check-sat)
; {getQuery/-116703388=([java.net.URL], java.lang.String), var1958_sort/-2094180924=([java.lang.Object[]], void), cast-from-__Array__Int__String__-to-__Array__Int__var2696__=([java.lang.String[]], java.lang.Object[])}
; {var2701=java.net.URL, var2186=r0, var282=$r1, var1473=null_type, var2872=$r3, var1805=$r2, var1958=java.util.Arrays, var2696=java.lang.Object}
; {java.net.URL=var2701, r0=var2186, $r1=var282, null_type=var1473, $r3=var2872, $r2=var1805, java.util.Arrays=var1958, java.lang.Object=var2696}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.URL;	$r1 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>();	if $r1 != null goto $r3 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>();	$r3 = virtualinvoke r0.<java.net.URL: java.lang.String getQuery()>();	$r2 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("&");	staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>($r2);	return $r2
;block_num 3