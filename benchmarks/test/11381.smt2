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

(declare-sort var1673 0)
(declare-sort var598 0)
(declare-sort var2465 0)
(declare-sort var1210 0)
(declare-sort var1273 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getConfig/1648771127 (var1673 String String) String)
(declare-fun var2465_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var1210-init () var1210)
(declare-fun <init>/-2084131130 (var1210 String var1273) void)
(declare-fun cast-from-String-to-var1273 (String) var1273)
(declare-const null-var1673 var1673)
(declare-const null-String String)
(declare-const var1231 var1673) ; Statement: r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport 
(assert (not (= var1231 null-var1673)))
(declare-const var415 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var415 null-String)))
(declare-const var1583 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1583 null-String)))
(assert true)
(define-const var2797 String (getConfig/1648771127 var1231 var415 var1583)) ; Statement: r3 = specialinvoke r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: java.lang.String getConfig(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1311 String "0") ; Statement: r6 = "0" 
(define-const var564 Bool (var2465_isNotEmpty/-1251449450 var2797)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = new org.apache.dubbo.common.config.configcenter.ConfigItem 
(assert (= (ite var564 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2151 var1210 var1210-init) ; Statement: $r4 = new org.apache.dubbo.common.config.configcenter.ConfigItem 
(assert true)
;(assert (<init>/-2084131130 var2151 var2797 (cast-from-String-to-var1273 var1311))) ; Statement: specialinvoke $r4.<org.apache.dubbo.common.config.configcenter.ConfigItem: void <init>(java.lang.String,java.lang.Object)>(r3, r6) 

(declare-const var2151!1 var1210)
(declare-const var2797!1 String)
(declare-const var1311!1 String)
 ; Statement: return $r4 
(check-sat)
; {getConfig/1648771127=([org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, java.lang.String, java.lang.String], java.lang.String), var2465_isNotEmpty/-1251449450=([java.lang.String], boolean), var1210-init=([], org.apache.dubbo.common.config.configcenter.ConfigItem), <init>/-2084131130=([org.apache.dubbo.common.config.configcenter.ConfigItem, java.lang.String, java.lang.Object], void), cast-from-String-to-var1273=([java.lang.String], java.lang.Object)}
; {var1673=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, var1231=r0, var415=r1, var598=null_type, var1583=r2, var2797=r3, var1311=r6, var2465=org.apache.dubbo.common.utils.StringUtils, var564=$z0, var1210=org.apache.dubbo.common.config.configcenter.ConfigItem, var2151=$r4, var1273=java.lang.Object}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport=var1673, r0=var1231, r1=var415, null_type=var598, r2=var1583, r3=var2797, r6=var1311, org.apache.dubbo.common.utils.StringUtils=var2465, $z0=var564, org.apache.dubbo.common.config.configcenter.ConfigItem=var1210, $r4=var2151, java.lang.Object=var1273}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = specialinvoke r0.<org.apache.dubbo.metadata.store.nacos.NacosMetadataReport: java.lang.String getConfig(java.lang.String,java.lang.String)>(r1, r2);	r6 = "0";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = new org.apache.dubbo.common.config.configcenter.ConfigItem;	$r4 = new org.apache.dubbo.common.config.configcenter.ConfigItem;	specialinvoke $r4.<org.apache.dubbo.common.config.configcenter.ConfigItem: void <init>(java.lang.String,java.lang.Object)>(r3, r6);	return $r4
;block_num 2