(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2785 0)
(declare-sort var1971 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var1971_containsKey/1715618542 (var1971 var2785) Bool)
(declare-fun cast-from-__Array__Int__var2785__-to-var2785 ((Array Int var2785)) var2785)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const null-__Array__Int__var2785__ (Array Int var2785))
(declare-const null-var1971 var1971)
(declare-const var2726 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2726 null-String)))
(declare-const var3760 (Array Int var2785)) ; Statement: r2 := @parameter1: java.lang.Object[] 
(assert (not (= var3760 null-__Array__Int__var2785__)))
(declare-const var2987 var1971) ; Statement: r1 := @parameter2: java.util.Map 
(assert (not (= var2987 null-var1971)))
(assert true)
;(assert (append/-1166366385 var2726 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91) 
(declare-const var2726!1 String)
(assert (str.prefixof var2726 var2726!1))
(define-const var132 Bool (var1971_containsKey/1715618542 var2987 (cast-from-__Array__Int__var2785__-to-var2785 var3760))) ; Statement: $z0 = interfaceinvoke r1.<java.util.Map: boolean containsKey(java.lang.Object)>(r2) 
 ; Statement: if $z0 != 0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("...") 
(assert (not (= (ite var132 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
;(assert (append/672562846 var2726!1 "...")) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("...") 
(declare-const var2726!2 String)
(assert (= var2726!2 (str.++ var2726!1 "...")))
(assert true) ; Non Conditional
(assert true)
;(assert (append/-1166366385 var2726!2 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93) 
(declare-const var2726!3 String)
(assert (str.prefixof var2726!2 var2726!3))
 ; Statement: return 
(check-sat)
; {append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var1971_containsKey/1715618542=([java.util.Map, java.lang.Object], boolean), cast-from-__Array__Int__var2785__-to-var2785=([java.lang.Object[]], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var2726=r0, var2785=java.lang.Object, var3760=r2, var1971=java.util.Map, var2987=r1, var132=$z0}
; {r0=var2726, java.lang.Object=var2785, r2=var3760, java.util.Map=var1971, r1=var2987, $z0=var132}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r2 := @parameter1: java.lang.Object[];	r1 := @parameter2: java.util.Map;	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91);	$z0 = interfaceinvoke r1.<java.util.Map: boolean containsKey(java.lang.Object)>(r2);	if $z0 != 0 goto virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("...");	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("...");	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(93);	return
;block_num 3