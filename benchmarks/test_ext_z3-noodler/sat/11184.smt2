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

(declare-sort var63 0)
(declare-sort var3418 0)
(declare-sort var3321 0)
(declare-sort var1959 0)
(declare-sort var3981 0)
(declare-sort var437 0)
(declare-sort var772 0)
(declare-sort var1315 0)
(declare-sort var3657 0)
(declare-sort var173 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getConfig/-1278229556 (var63 var3321) String)
(declare-fun cast-from-var3418-to-var3321 (var3418) var3321)
(declare-fun var1959_isEmpty/-813097145 (String) Bool)
(declare-fun var3981-init () var3981)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var437_decode/179454741 (String) String)
(declare-fun var1315_asList/1779083644 ((Array Int var3657)) var772)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3657__ ((Array Int String)) (Array Int var3657))
(declare-fun <init>/2032108350 (var3981 var173) void)
(declare-fun cast-from-var772-to-var173 (var772) var173)
(declare-const null-var63 var63)
(declare-const null-var3418 var3418)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2145 var63) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport 
(assert (not (= var2145 null-var63)))
(declare-const var3350 var3418) ; Statement: r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier 
(assert (not (= var3350 null-var3418)))
(assert true)
(define-const var3932 String (getConfig/-1278229556 var2145 (cast-from-var3418-to-var3321 var3350))) ; Statement: r2 = specialinvoke r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: java.lang.String getConfig(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1) 
(define-const var2501 Bool (var1959_isEmpty/-813097145 var3932)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = new java.util.ArrayList 
(assert (= (ite var2501 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1032 var3981 var3981-init) ; Statement: $r3 = new java.util.ArrayList 
(define-const var398 (Array Int String) arr-String-init) ; Statement: $r4 = newarray (java.lang.String)[1] 
(define-const var61 String (var437_decode/179454741 var3932)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String decode(java.lang.String)>(r2) 
(declare-const var398!1 (Array Int String))
(assert (not (= var398!1 null-__Array__Int__String__)))
(assert (= (select var398!1 0) var61)) ; Statement: $r4[0] = $r5 
(define-const var1898 var772 (var1315_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3657__ var398!1))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r4) 
(assert true)
;(assert (<init>/2032108350 var1032 (cast-from-var772-to-var173 var1898))) ; Statement: specialinvoke $r3.<java.util.ArrayList: void <init>(java.util.Collection)>($r6) 

(declare-const var1032!1 var3981)
(declare-const var1898!1 var772)
 ; Statement: return $r3 
(check-sat)
; {getConfig/-1278229556=([org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier], java.lang.String), cast-from-var3418-to-var3321=([org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier), var1959_isEmpty/-813097145=([java.lang.String], boolean), var3981-init=([], java.util.ArrayList), arr-String-init=([], java.lang.String[]), var437_decode/179454741=([java.lang.String], java.lang.String), var1315_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var3657__=([java.lang.String[]], java.lang.Object[]), <init>/2032108350=([java.util.ArrayList, java.util.Collection], void), cast-from-var772-to-var173=([java.util.List], java.util.Collection)}
; {var63=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, var2145=r0, var3418=org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier, var3350=r1, var3321=org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier, var3932=r2, var1959=org.apache.dubbo.common.utils.StringUtils, var2501=$z0, var3981=java.util.ArrayList, var1032=$r3, var398=$r4, var437=org.apache.dubbo.common.URL, var61=$r5, var772=java.util.List, var1315=java.util.Arrays, var3657=java.lang.Object, var1898=$r6, var173=java.util.Collection}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport=var63, r0=var2145, org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier=var3418, r1=var3350, org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier=var3321, r2=var3932, org.apache.dubbo.common.utils.StringUtils=var1959, $z0=var2501, java.util.ArrayList=var3981, $r3=var1032, $r4=var398, org.apache.dubbo.common.URL=var437, $r5=var61, java.util.List=var772, java.util.Arrays=var1315, java.lang.Object=var3657, $r6=var1898, java.util.Collection=var173}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport;	r1 := @parameter0: org.apache.dubbo.metadata.report.identifier.ServiceMetadataIdentifier;	r2 = specialinvoke r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: java.lang.String getConfig(org.apache.dubbo.metadata.report.identifier.BaseMetadataIdentifier)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = new java.util.ArrayList;	$r3 = new java.util.ArrayList;	$r4 = newarray (java.lang.String)[1];	$r5 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String decode(java.lang.String)>(r2);	$r4[0] = $r5;	$r6 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r4);	specialinvoke $r3.<java.util.ArrayList: void <init>(java.util.Collection)>($r6);	return $r3
;block_num 2