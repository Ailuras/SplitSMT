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

(declare-sort var431 0)
(declare-sort var1137 0)
(declare-sort var1318 0)
(declare-sort var1747 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var431 var431)
(declare-const null-String String)
(declare-const null-var1318 var1318)
(declare-const var1747-EXECUTOR_SERVICE_COMPONENT_KEY String)
(declare-const var199 var431) ; Statement: r4 := @this: org.apache.dubbo.metrics.collector.sample.ThreadPoolMetricsSampler 
(assert (not (= var199 null-var431)))
(declare-const var1404 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1404 null-String)))
(declare-const var2839 String) ; Statement: r6 := @parameter1: java.lang.String 
(assert (not (= var2839 null-String)))
(declare-const var1402 var1318) ; Statement: r3 := @parameter2: java.lang.Object 
(assert (not (= var1402 null-var1318)))
(define-const var3457 String var1747-EXECUTOR_SERVICE_COMPONENT_KEY) ; Statement: $r1 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY> 
(assert true)
(define-const var1194 Bool (= var3457 var1404)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "CONSUMER_SHARED_SERVICE_EXECUTOR" 
(assert (not (= (ite var1194 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3091 Bool false) ; Statement: $z3 = r3 instanceof java.util.concurrent.ThreadPoolExecutor 
 ; Statement: if $z3 == 0 goto return 
(assert (= (ite var3091 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: return 
(check-sat)
; {}
; {var431=org.apache.dubbo.metrics.collector.sample.ThreadPoolMetricsSampler, var199=r4, var1404=r0, var1137=null_type, var2839=r6, var1318=java.lang.Object, var1402=r3, var1747=org.apache.dubbo.common.constants.CommonConstants, var3457=$r1, var1194=$z0, var3091=$z3}
; {org.apache.dubbo.metrics.collector.sample.ThreadPoolMetricsSampler=var431, r4=var199, r0=var1404, null_type=var1137, r6=var2839, java.lang.Object=var1318, r3=var1402, org.apache.dubbo.common.constants.CommonConstants=var1747, $r1=var3457, $z0=var1194, $z3=var3091}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.metrics.collector.sample.ThreadPoolMetricsSampler;	r0 := @parameter0: java.lang.String;	r6 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.Object;	$r1 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "CONSUMER_SHARED_SERVICE_EXECUTOR";	$z3 = r3 instanceof java.util.concurrent.ThreadPoolExecutor;	if $z3 == 0 goto return;	return
;block_num 3