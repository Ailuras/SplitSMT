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

(declare-sort var50 0)
(declare-sort var359 0)
(declare-sort var2214 0)
(declare-sort var18 0)
(declare-sort var3465 0)
(declare-sort var1295 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getConfig/235622967 (var2214 String String) String)
(declare-fun cast-from-var50-to-var2214 (var50) var2214)
(declare-fun var18_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var3465-init () var3465)
(declare-fun <init>/-2084131130 (var3465 String var1295) void)
(declare-fun cast-from-String-to-var1295 (String) var1295)
(declare-const null-var50 var50)
(declare-const null-String String)
(declare-const var489 var50) ; Statement: r0 := @this: org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration 
(assert (not (= var489 null-var50)))
(declare-const var2463 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2463 null-String)))
(declare-const var899 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var899 null-String)))
(assert true)
(define-const var3978 String (getConfig/235622967 (cast-from-var50-to-var2214 var489) var2463 var899)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration: java.lang.String getConfig(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1642 String "") ; Statement: r6 = "" 
(define-const var179 Bool (var18_isNotEmpty/-1251449450 var3978)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r4 = new org.apache.dubbo.common.config.configcenter.ConfigItem 
(assert (= (ite var179 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2558 var3465 var3465-init) ; Statement: $r4 = new org.apache.dubbo.common.config.configcenter.ConfigItem 
(assert true)
;(assert (<init>/-2084131130 var2558 var3978 (cast-from-String-to-var1295 var1642))) ; Statement: specialinvoke $r4.<org.apache.dubbo.common.config.configcenter.ConfigItem: void <init>(java.lang.String,java.lang.Object)>(r3, r6) 

(declare-const var2558!1 var3465)
(declare-const var3978!1 String)
(declare-const var1642!1 String)
 ; Statement: return $r4 
(check-sat)
; {getConfig/235622967=([org.apache.dubbo.common.config.configcenter.DynamicConfiguration, java.lang.String, java.lang.String], java.lang.String), cast-from-var50-to-var2214=([org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration], org.apache.dubbo.common.config.configcenter.DynamicConfiguration), var18_isNotEmpty/-1251449450=([java.lang.String], boolean), var3465-init=([], org.apache.dubbo.common.config.configcenter.ConfigItem), <init>/-2084131130=([org.apache.dubbo.common.config.configcenter.ConfigItem, java.lang.String, java.lang.Object], void), cast-from-String-to-var1295=([java.lang.String], java.lang.Object)}
; {var50=org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration, var489=r0, var2463=r1, var359=null_type, var899=r2, var2214=org.apache.dubbo.common.config.configcenter.DynamicConfiguration, var3978=r3, var1642=r6, var18=org.apache.dubbo.common.utils.StringUtils, var179=$z0, var3465=org.apache.dubbo.common.config.configcenter.ConfigItem, var2558=$r4, var1295=java.lang.Object}
; {org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration=var50, r0=var489, r1=var2463, null_type=var359, r2=var899, org.apache.dubbo.common.config.configcenter.DynamicConfiguration=var2214, r3=var3978, r6=var1642, org.apache.dubbo.common.utils.StringUtils=var18, $z0=var179, org.apache.dubbo.common.config.configcenter.ConfigItem=var3465, $r4=var2558, java.lang.Object=var1295}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration: java.lang.String getConfig(java.lang.String,java.lang.String)>(r1, r2);	r6 = "";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r4 = new org.apache.dubbo.common.config.configcenter.ConfigItem;	$r4 = new org.apache.dubbo.common.config.configcenter.ConfigItem;	specialinvoke $r4.<org.apache.dubbo.common.config.configcenter.ConfigItem: void <init>(java.lang.String,java.lang.Object)>(r3, r6);	return $r4
;block_num 2