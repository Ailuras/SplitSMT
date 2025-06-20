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

(declare-sort var1622 0)
(declare-sort var1947 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var1947) String)
(declare-fun setMock/136566133 (var1622 String) void)
(declare-const null-var1622 var1622)
(declare-const null-var1947 var1947)
(declare-const var2776 var1622) ; Statement: r1 := @this: org.apache.dubbo.config.AbstractMethodConfig 
(assert (not (= var2776 null-var1622)))
(declare-const var3736 var1947) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var3736 null-var1947)))
 ; Statement: if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var3736 null-var1947))) ; Cond: r0 != null 
(define-const var669 String (String_valueOf/-333372740 var3736)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
;(assert (setMock/136566133 var2776 var669)) ; Statement: virtualinvoke r1.<org.apache.dubbo.config.AbstractMethodConfig: void setMock(java.lang.String)>($r2) 

(declare-const var2776!1 var1622)
(declare-const var669!1 String)
 ; Statement: return 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), setMock/136566133=([org.apache.dubbo.config.AbstractMethodConfig, java.lang.String], void)}
; {var1622=org.apache.dubbo.config.AbstractMethodConfig, var2776=r1, var1947=java.lang.Object, var3736=r0, var669=$r2}
; {org.apache.dubbo.config.AbstractMethodConfig=var1622, r1=var2776, java.lang.Object=var1947, r0=var3736, $r2=var669}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.AbstractMethodConfig;	r0 := @parameter0: java.lang.Object;	if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	virtualinvoke r1.<org.apache.dubbo.config.AbstractMethodConfig: void setMock(java.lang.String)>($r2);	return
;block_num 2