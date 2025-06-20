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

(declare-sort var2715 0)
(declare-sort var2706 0)
(declare-sort var1263 0)
(declare-sort var3386 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2706_notNull/751190363 (var1263 String) void)
(declare-fun cast-from-String-to-var1263 (String) var1263)
(declare-fun var3386_values/-1577137613 () (Array Int var3386))
(declare-fun getLength-Arr-var3386-1 ((Array Int var3386)) Int)
(declare-fun matches/-1454705646 (var3386 String) Bool)
(declare-const null-String String)
(declare-const var2889 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2889 null-String)))
;(assert (var2706_notNull/751190363 (cast-from-String-to-var1263 var2889) "Value must not be null")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "Value must not be null") 

(declare-const var2889!1 String)
(declare-const var3677 String)
(define-const var3926 (Array Int var3386) var3386_values/-1577137613) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle[] values()>() 
(define-const var3854 Int (getLength-Arr-var3386-1 var3926)) ; Statement: i0 = lengthof r1 
(define-const var855 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r2 = new java.lang.IllegalArgumentException 
(assert (not (>= var855 var3854))) ; Negate: Cond: i1 >= i0  
(define-const var2726 var3386 (select var3926 var855)) ; Statement: r8 = r1[i1] 
(assert true)
(define-const var2586 Bool (matches/-1454705646 var2726 var2889!1)) ; Statement: $z0 = virtualinvoke r8.<org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle: boolean matches(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto i1 = i1 + 1 
(assert (not (= (ite var2586 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r8 
(check-sat)
; {var2706_notNull/751190363=([java.lang.Object, java.lang.String], void), cast-from-String-to-var1263=([java.lang.String], java.lang.Object), var3386_values/-1577137613=([], org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle[]), getLength-Arr-var3386-1=([org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle[]], int), matches/-1454705646=([org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle, java.lang.String], boolean)}
; {var2889=r0, var2715=null_type, var2706=org.apache.dubbo.common.utils.Assert, var1263=java.lang.Object, var3677="Value must not be null", var3386=org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle, var3926=r1, var3854=i0, var855=i1, var2726=r8, var2586=$z0}
; {r0=var2889, null_type=var2715, org.apache.dubbo.common.utils.Assert=var2706, java.lang.Object=var1263, "Value must not be null"=var3677, org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle=var3386, r1=var3926, i0=var3854, i1=var855, r8=var2726, $z0=var2586}
;seq 
;cnt {}
;stmts r0 := @parameter0: java.lang.String;	staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r0, "Value must not be null");	r1 = staticinvoke <org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle: org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle[] values()>();	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto $r2 = new java.lang.IllegalArgumentException;	r8 = r1[i1];	$z0 = virtualinvoke r8.<org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle: boolean matches(java.lang.String)>(r0);	if $z0 == 0 goto i1 = i1 + 1;	return r8
;block_num 4