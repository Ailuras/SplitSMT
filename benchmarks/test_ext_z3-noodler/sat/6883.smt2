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

(declare-sort var398 0)
(declare-sort var1410 0)
(declare-sort var3307 0)
(declare-sort var1423 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3307) String)
(declare-fun cast-from-var1410-to-var3307 (var1410) var3307)
(declare-fun setMock/136566133 (var1423 String) void)
(declare-fun cast-from-var398-to-var1423 (var398) var1423)
(declare-const null-var398 var398)
(declare-const null-var1410 var1410)
(declare-const var2068 var398) ; Statement: r1 := @this: com.alibaba.dubbo.config.MethodConfig 
(assert (not (= var2068 null-var398)))
(declare-const var3776 var1410) ; Statement: r0 := @parameter0: java.lang.Boolean 
(assert (not (= var3776 null-var1410)))
 ; Statement: if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var3776 null-var1410))) ; Cond: r0 != null 
(define-const var2810 String (String_valueOf/-333372740 (cast-from-var1410-to-var3307 var3776))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
;(assert (setMock/136566133 (cast-from-var398-to-var1423 var2068) var2810)) ; Statement: virtualinvoke r1.<com.alibaba.dubbo.config.MethodConfig: void setMock(java.lang.String)>($r2) 

(declare-const var2068!1 var398)
(declare-const var2810!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var1410-to-var3307=([java.lang.Boolean], java.lang.Object), setMock/136566133=([org.apache.dubbo.config.AbstractMethodConfig, java.lang.String], void), cast-from-var398-to-var1423=([com.alibaba.dubbo.config.MethodConfig], org.apache.dubbo.config.AbstractMethodConfig)}
; {var398=com.alibaba.dubbo.config.MethodConfig, var2068=r1, var1410=java.lang.Boolean, var3776=r0, var3307=java.lang.Object, var2810=$r2, var1423=org.apache.dubbo.config.AbstractMethodConfig}
; {com.alibaba.dubbo.config.MethodConfig=var398, r1=var2068, java.lang.Boolean=var1410, r0=var3776, java.lang.Object=var3307, $r2=var2810, org.apache.dubbo.config.AbstractMethodConfig=var1423}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.config.MethodConfig;	r0 := @parameter0: java.lang.Boolean;	if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	virtualinvoke r1.<com.alibaba.dubbo.config.MethodConfig: void setMock(java.lang.String)>($r2);	return
;block_num 3