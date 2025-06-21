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

(declare-sort var2644 0)
(declare-sort var625 0)
(declare-sort var1443 0)
(declare-sort var1452 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRegistry/250858936 (var625) String)
(declare-fun var1452_isEmpty/-813097145 (String) Bool)
(declare-fun getParameter/-1307325648 (var1443 String) String)
(declare-const null-var2644 var2644)
(declare-const null-var625 var625)
(declare-const null-var1443 var1443)
(declare-const var3006 var2644) ; Statement: r7 := @this: org.apache.dubbo.metadata.report.MetadataReportInstance 
(assert (not (= var3006 null-var2644)))
(declare-const var1609 var625) ; Statement: r0 := @parameter0: org.apache.dubbo.config.MetadataReportConfig 
(assert (not (= var1609 null-var625)))
(declare-const var1828 var1443) ; Statement: r1 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1828 null-var1443)))
(assert true)
(define-const var1624 String (getRegistry/250858936 var1609)) ; Statement: r8 = virtualinvoke r0.<org.apache.dubbo.config.MetadataReportConfig: java.lang.String getRegistry()>() 
(define-const var3877 Bool (var1452_isEmpty/-813097145 var1624)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8) 
(assert (= (ite var3877 1 0) 0)) ; Cond: $z0 == 0 
(define-const var66 Bool (var1452_isEmpty/-813097145 var1624)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8) 
 ; Statement: if $z1 == 0 goto $r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace") 
(assert (= (ite var66 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var355 String (getParameter/-1307325648 var1828 "namespace")) ; Statement: $r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace") 
(define-const var1936 Bool (var1452_isEmpty/-813097145 var355)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r6) 
 ; Statement: if $z2 != 0 goto return r8 
(assert (not (= (ite var1936 1 0) 0))) ; Cond: $z2 != 0 
 ; Statement: return r8 
(check-sat)
; {getRegistry/250858936=([org.apache.dubbo.config.MetadataReportConfig], java.lang.String), var1452_isEmpty/-813097145=([java.lang.String], boolean), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String)}
; {var2644=org.apache.dubbo.metadata.report.MetadataReportInstance, var3006=r7, var625=org.apache.dubbo.config.MetadataReportConfig, var1609=r0, var1443=org.apache.dubbo.common.URL, var1828=r1, var1624=r8, var1452=org.apache.dubbo.common.utils.StringUtils, var3877=$z0, var66=$z1, var355=$r6, var1936=$z2}
; {org.apache.dubbo.metadata.report.MetadataReportInstance=var2644, r7=var3006, org.apache.dubbo.config.MetadataReportConfig=var625, r0=var1609, org.apache.dubbo.common.URL=var1443, r1=var1828, r8=var1624, org.apache.dubbo.common.utils.StringUtils=var1452, $z0=var3877, $z1=var66, $r6=var355, $z2=var1936}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 3}
;stmts r7 := @this: org.apache.dubbo.metadata.report.MetadataReportInstance;	r0 := @parameter0: org.apache.dubbo.config.MetadataReportConfig;	r1 := @parameter1: org.apache.dubbo.common.URL;	r8 = virtualinvoke r0.<org.apache.dubbo.config.MetadataReportConfig: java.lang.String getRegistry()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8);	if $z1 == 0 goto $r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace");	$r6 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace");	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r6);	if $z2 != 0 goto return r8;	return r8
;block_num 4