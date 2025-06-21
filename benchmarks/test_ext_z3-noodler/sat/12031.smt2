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

(declare-sort var2018 0)
(declare-sort var1251 0)
(declare-sort var2300 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun allApplication/644543526 (var2018 var2300) String)
(declare-const null-var2018 var2018)
(declare-const null-String String)
(declare-const null-var2300 var2300)
(declare-const var3395 var2018) ; Statement: r2 := @this: org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd 
(assert (not (= var3395 null-var2018)))
(declare-const var3913 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3913 null-String)))
(declare-const var359 var2300) ; Statement: r3 := @parameter1: java.util.List 
(assert (not (= var359 null-var2300)))
(define-const var953 String "application_all") ; Statement: $r1 = "application_all" 
(assert true)
(define-const var3681 Bool (= var953 var3913)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r4 = specialinvoke r2.<org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List)>(r0, r3) 
(assert (not (= (ite var3681 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var120 String (allApplication/644543526 var3395 var359)) ; Statement: $r5 = specialinvoke r2.<org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd: java.lang.String allApplication(java.util.List)>(r3) 
 ; Statement: return $r5 
(check-sat)
; {allApplication/644543526=([org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd, java.util.List], java.lang.String)}
; {var2018=org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd, var3395=r2, var3913=r0, var1251=null_type, var2300=java.util.List, var359=r3, var953=$r1, var3681=$z0, var120=$r5}
; {org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd=var2018, r2=var3395, r0=var3913, null_type=var1251, java.util.List=var2300, r3=var359, $r1=var953, $z0=var3681, $r5=var120}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd;	r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.List;	$r1 = "application_all";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r4 = specialinvoke r2.<org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List)>(r0, r3);	$r5 = specialinvoke r2.<org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd: java.lang.String allApplication(java.util.List)>(r3);	return $r5
;block_num 2