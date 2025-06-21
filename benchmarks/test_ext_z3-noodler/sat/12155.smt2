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

(declare-sort var3116 0)
(declare-sort var3076 0)
(declare-sort var1613 0)
(declare-sort var3307 0)
(declare-sort var1473 0)
(declare-sort var3848 0)
(declare-sort var2855 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun tracingConfig/2115835412 (var3116) var3076)
(declare-fun getTracingExporter/892277660 (var3076) var1613)
(declare-fun var3307-init () var3307)
(declare-fun <init>/-325640736 (var3307) void)
(declare-fun var1473_isSupportBraveURLSender/-350658454 () Bool)
(declare-fun getZipkinConfig/619993399 (var1613) var3848)
(declare-fun getEndpoint/-784343702 (var3848) String)
(declare-fun var2855_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3116 var3116)
(declare-const null-var3848 var3848)
(declare-const var3311 var3116) ; Statement: r0 := @this: org.apache.dubbo.tracing.tracer.brave.BraveProvider 
(assert (not (= var3311 null-var3116)))
(define-const var2719 var3076 (tracingConfig/2115835412 var3311)) ; Statement: $r1 = r0.<org.apache.dubbo.tracing.tracer.brave.BraveProvider: org.apache.dubbo.config.TracingConfig tracingConfig> 
(assert true)
(define-const var1104 var1613 (getTracingExporter/892277660 var2719)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.config.TracingConfig: org.apache.dubbo.config.nested.ExporterConfig getTracingExporter()>() 
(define-const var3947 var3307 var3307-init) ; Statement: $r3 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3947)) ; Statement: specialinvoke $r3.<java.util.ArrayList: void <init>()>() 

(declare-const var3947!1 var3307)
(define-const var1728 Bool var1473_isSupportBraveURLSender/-350658454) ; Statement: $z0 = staticinvoke <org.apache.dubbo.tracing.utils.ObservationSupportUtil: boolean isSupportBraveURLSender()>() 
 ; Statement: if $z0 != 0 goto r4 = virtualinvoke r2.<org.apache.dubbo.config.nested.ExporterConfig: org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig getZipkinConfig()>() 
(assert (not (= (ite var1728 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var3561 var3848 (getZipkinConfig/619993399 var1104)) ; Statement: r4 = virtualinvoke r2.<org.apache.dubbo.config.nested.ExporterConfig: org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig getZipkinConfig()>() 
 ; Statement: if r4 == null goto return $r3 
(assert (not (= var3561 null-var3848))) ; Negate: Cond: r4 == null  
(assert true)
(define-const var2574 String (getEndpoint/-784343702 var3561)) ; Statement: $r5 = virtualinvoke r4.<org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig: java.lang.String getEndpoint()>() 
(define-const var3209 Bool (var2855_isNotEmpty/-1251449450 var2574)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r5) 
 ; Statement: if $z1 == 0 goto return $r3 
(assert (= (ite var3209 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return $r3 
(check-sat)
; {tracingConfig/2115835412=([org.apache.dubbo.tracing.tracer.brave.BraveProvider], org.apache.dubbo.config.TracingConfig), getTracingExporter/892277660=([org.apache.dubbo.config.TracingConfig], org.apache.dubbo.config.nested.ExporterConfig), var3307-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var1473_isSupportBraveURLSender/-350658454=([], boolean), getZipkinConfig/619993399=([org.apache.dubbo.config.nested.ExporterConfig], org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig), getEndpoint/-784343702=([org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig], java.lang.String), var2855_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3116=org.apache.dubbo.tracing.tracer.brave.BraveProvider, var3311=r0, var3076=org.apache.dubbo.config.TracingConfig, var2719=$r1, var1613=org.apache.dubbo.config.nested.ExporterConfig, var1104=r2, var3307=java.util.ArrayList, var3947=$r3, var1473=org.apache.dubbo.tracing.utils.ObservationSupportUtil, var1728=$z0, var3848=org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig, var3561=r4, var2574=$r5, var2855=org.apache.dubbo.common.utils.StringUtils, var3209=$z1}
; {org.apache.dubbo.tracing.tracer.brave.BraveProvider=var3116, r0=var3311, org.apache.dubbo.config.TracingConfig=var3076, $r1=var2719, org.apache.dubbo.config.nested.ExporterConfig=var1613, r2=var1104, java.util.ArrayList=var3307, $r3=var3947, org.apache.dubbo.tracing.utils.ObservationSupportUtil=var1473, $z0=var1728, org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig=var3848, r4=var3561, $r5=var2574, org.apache.dubbo.common.utils.StringUtils=var2855, $z1=var3209}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.tracing.tracer.brave.BraveProvider;	$r1 = r0.<org.apache.dubbo.tracing.tracer.brave.BraveProvider: org.apache.dubbo.config.TracingConfig tracingConfig>;	r2 = virtualinvoke $r1.<org.apache.dubbo.config.TracingConfig: org.apache.dubbo.config.nested.ExporterConfig getTracingExporter()>();	$r3 = new java.util.ArrayList;	specialinvoke $r3.<java.util.ArrayList: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.tracing.utils.ObservationSupportUtil: boolean isSupportBraveURLSender()>();	if $z0 != 0 goto r4 = virtualinvoke r2.<org.apache.dubbo.config.nested.ExporterConfig: org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig getZipkinConfig()>();	r4 = virtualinvoke r2.<org.apache.dubbo.config.nested.ExporterConfig: org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig getZipkinConfig()>();	if r4 == null goto return $r3;	$r5 = virtualinvoke r4.<org.apache.dubbo.config.nested.ExporterConfig$ZipkinConfig: java.lang.String getEndpoint()>();	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r5);	if $z1 == 0 goto return $r3;	return $r3
;block_num 4