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

(declare-sort var3989 0)
(declare-sort var1666 0)
(declare-sort var2438 0)
(declare-sort var3934 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var3989 var3989)
(declare-const null-String String)
(declare-const null-var2438 var2438)
(declare-const var3934-EXECUTOR_SERVICE_COMPONENT_KEY String)
(declare-const var1580 var3989) ; Statement: r4 := @this: org.apache.dubbo.metrics.collector.sample.ThreadPoolMetricsSampler 
(assert (not (= var1580 null-var3989)))
(declare-const var3903 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3903 null-String)))
(declare-const var1480 String) ; Statement: r6 := @parameter1: java.lang.String 
(assert (not (= var1480 null-String)))
(declare-const var665 var2438) ; Statement: r3 := @parameter2: java.lang.Object 
(assert (not (= var665 null-var2438)))
(define-const var2273 String var3934-EXECUTOR_SERVICE_COMPONENT_KEY) ; Statement: $r1 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY> 
(assert true)
(define-const var3453 Bool (= var2273 var3903)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "CONSUMER_SHARED_SERVICE_EXECUTOR" 
(assert (= (ite var3453 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1317 String "CONSUMER_SHARED_SERVICE_EXECUTOR") ; Statement: $r2 = "CONSUMER_SHARED_SERVICE_EXECUTOR" 
(assert true)
(define-const var3189 Bool (= var1317 var3903)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var3189 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {}
; {var3989=org.apache.dubbo.metrics.collector.sample.ThreadPoolMetricsSampler, var1580=r4, var3903=r0, var1666=null_type, var1480=r6, var2438=java.lang.Object, var665=r3, var3934=org.apache.dubbo.common.constants.CommonConstants, var2273=$r1, var3453=$z0, var1317=$r2, var3189=$z1}
; {org.apache.dubbo.metrics.collector.sample.ThreadPoolMetricsSampler=var3989, r4=var1580, r0=var3903, null_type=var1666, r6=var1480, java.lang.Object=var2438, r3=var665, org.apache.dubbo.common.constants.CommonConstants=var3934, $r1=var2273, $z0=var3453, $r2=var1317, $z1=var3189}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r4 := @this: org.apache.dubbo.metrics.collector.sample.ThreadPoolMetricsSampler;	r0 := @parameter0: java.lang.String;	r6 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.Object;	$r1 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "CONSUMER_SHARED_SERVICE_EXECUTOR";	$r2 = "CONSUMER_SHARED_SERVICE_EXECUTOR";	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z1 == 0 goto return;	return
;block_num 3