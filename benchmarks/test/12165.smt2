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

(declare-sort var2843 0)
(declare-sort var680 0)
(declare-sort var1383 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2843_getAttachment/-2134772037 (var2843 String) String)
(declare-fun String_valueOf/-333372740 (var1383) String)
(declare-fun cast-from-String-to-var1383 (String) var1383)
(declare-const null-var2843 var2843)
(declare-const null-String String)
(declare-const var700 var2843) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var700 null-var2843)))
(declare-const var2680 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2680 null-String)))
(define-const var917 String (var2843_getAttachment/-2134772037 var700 var2680)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>(r1) 
(define-const var3062 String (String_valueOf/-333372740 (cast-from-String-to-var1383 var917))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r2) 
 ; Statement: return $r3 
(check-sat)
; {var2843_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-String-to-var1383=([java.lang.String], java.lang.Object)}
; {var2843=org.apache.dubbo.rpc.Invocation, var700=r0, var2680=r1, var680=null_type, var917=$r2, var1383=java.lang.Object, var3062=$r3}
; {org.apache.dubbo.rpc.Invocation=var2843, r0=var700, r1=var2680, null_type=var680, $r2=var917, java.lang.Object=var1383, $r3=var3062}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	r1 := @parameter1: java.lang.String;	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>(r1);	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r2);	return $r3
;block_num 1