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

(declare-sort var2234 0)
(declare-sort var3350 0)
(declare-sort var3536 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun specifySingleApplication/1811323615 (var2234 String var3536) String)
(declare-const null-var2234 var2234)
(declare-const null-String String)
(declare-const null-var3536 var3536)
(declare-const var1490 var2234) ; Statement: r2 := @this: org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd 
(assert (not (= var1490 null-var2234)))
(declare-const var2296 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2296 null-String)))
(declare-const var676 var3536) ; Statement: r3 := @parameter1: java.util.List 
(assert (not (= var676 null-var3536)))
(define-const var401 String "application_all") ; Statement: $r1 = "application_all" 
(assert true)
(define-const var538 Bool (= var401 var2296)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r4 = specialinvoke r2.<org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List)>(r0, r3) 
(assert (= (ite var538 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1293 String (specifySingleApplication/1811323615 var1490 var2296 var676)) ; Statement: $r4 = specialinvoke r2.<org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List)>(r0, r3) 
 ; Statement: return $r4 
(check-sat)
; {specifySingleApplication/1811323615=([org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd, java.lang.String, java.util.List], java.lang.String)}
; {var2234=org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd, var1490=r2, var2296=r0, var3350=null_type, var3536=java.util.List, var676=r3, var401=$r1, var538=$z0, var1293=$r4}
; {org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd=var2234, r2=var1490, r0=var2296, null_type=var3350, java.util.List=var3536, r3=var676, $r1=var401, $z0=var538, $r4=var1293}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd;	r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.List;	$r1 = "application_all";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r4 = specialinvoke r2.<org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List)>(r0, r3);	$r4 = specialinvoke r2.<org.apache.dubbo.metrics.prometheus.PrometheusMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List)>(r0, r3);	return $r4
;block_num 2