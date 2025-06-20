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

(declare-sort var1660 0)
(declare-sort var1210 0)
(declare-sort var1477 0)
(declare-sort var588 0)
(declare-sort var3042 0)
(declare-sort var3444 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getIdentifier/-338683473 (var3042) String)
(declare-fun cast-from-var1660-to-var3042 (var1660) var3042)
(declare-fun getMessage/849299655 (var1477) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var588_error/377575788 (var588 String String String String var1477) void)
(declare-fun referenceCache/-1953096320 (var1660) var3444)
(declare-fun destroy/330892769 (var3444 var1210) void)
(declare-const null-var1660 var1660)
(declare-const null-var1210 var1210)
(declare-const null-var1477 var1477)
(declare-const var1660-logger var588)
(declare-const var1801 var1660) ; Statement: r1 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer 
(assert (not (= var1801 null-var1660)))
(declare-const var2986 var1210) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var2986 null-var1210)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3505 var1477) ; Statement: $r10 := @caughtexception 
(assert (not (= var3505 null-var1477)))
(define-const var3391 var588 var1660-logger) ; Statement: $r12 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var234 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var234)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var234!1 String)
(assert (= var234!1 ""))
(assert true)
(define-const var872 String (append/672562846 var234!1 "Model reference failed: ")) ; Statement: $r14 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Model reference failed: ") 
(declare-const var234!2 String)
(assert (= var234!2 (str.++ var234!1 "Model reference failed: ")))
(assert true)
(define-const var0 String (getIdentifier/-338683473 (cast-from-var1660-to-var3042 var1801))) ; Statement: $r13 = virtualinvoke r1.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>() 
(assert true)
(define-const var3177 String (append/672562846 var872 var0)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var872!1 String)
(assert (= var872!1 (str.++ var872 var0)))
(assert true)
(define-const var2464 String (append/672562846 var3177 " , catch error : ")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , catch error : ") 
(declare-const var3177!1 String)
(assert (= var3177!1 (str.++ var3177 " , catch error : ")))
(assert true)
(define-const var47 String (getMessage/849299655 var3505)) ; Statement: $r16 = virtualinvoke $r10.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var2686 String (append/672562846 var2464 var47)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var2464!1 String)
(assert (= var2464!1 (str.++ var2464 var47)))
(assert true)
(define-const var3890 String (toString/-2075883882 var2686)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var588_error/377575788 var3391 "5-15" "" "" var3890 var3505)) ; Statement: interfaceinvoke $r12.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-15", "", "", $r19, $r10) 

(declare-const var3391!1 var588)
(declare-const var1334 String)
(declare-const var1752 String)
(declare-const var1752!1 String)
(declare-const var3890!1 String)
(declare-const var3505!1 var1477)
(define-const var3395 var3444 (referenceCache/-1953096320 var1801)) ; Statement: $r20 = r1.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.config.utils.SimpleReferenceCache referenceCache> 
(assert true)
;(assert (destroy/330892769 var3395 var2986)) ; Statement: virtualinvoke $r20.<org.apache.dubbo.config.utils.SimpleReferenceCache: void destroy(org.apache.dubbo.config.ReferenceConfigBase)>(r0) 

(declare-const var3395!1 var3444)
(declare-const var2986!1 var1210)
 ; Statement: throw $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getIdentifier/-338683473=([org.apache.dubbo.common.deploy.AbstractDeployer], java.lang.String), cast-from-var1660-to-var3042=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.common.deploy.AbstractDeployer), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var588_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), referenceCache/-1953096320=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.config.utils.SimpleReferenceCache), destroy/330892769=([org.apache.dubbo.config.utils.SimpleReferenceCache, org.apache.dubbo.config.ReferenceConfigBase], void)}
; {var1660=org.apache.dubbo.config.deploy.DefaultModuleDeployer, var1801=r1, var1210=org.apache.dubbo.config.ReferenceConfigBase, var2986=r0, var1477=java.lang.Throwable, var3505=$r10, var588=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3391=$r12, var234=$r11, var872=$r14, var3042=org.apache.dubbo.common.deploy.AbstractDeployer, var0=$r13, var3177=$r15, var2464=$r17, var47=$r16, var2686=$r18, var3890=$r19, var1334="5-15", var1752="", var3444=org.apache.dubbo.config.utils.SimpleReferenceCache, var3395=$r20}
; {org.apache.dubbo.config.deploy.DefaultModuleDeployer=var1660, r1=var1801, org.apache.dubbo.config.ReferenceConfigBase=var1210, r0=var2986, java.lang.Throwable=var1477, $r10=var3505, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var588, $r12=var3391, $r11=var234, $r14=var872, org.apache.dubbo.common.deploy.AbstractDeployer=var3042, $r13=var0, $r15=var3177, $r17=var2464, $r16=var47, $r18=var2686, $r19=var3890, "5-15"=var1334, ""=var1752, org.apache.dubbo.config.utils.SimpleReferenceCache=var3444, $r20=var3395}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer;	r0 := @parameter0: org.apache.dubbo.config.ReferenceConfigBase;	$r10 := @caughtexception;	$r12 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Model reference failed: ");	$r13 = virtualinvoke r1.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , catch error : ");	$r16 = virtualinvoke $r10.<java.lang.Throwable: java.lang.String getMessage()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r12.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-15", "", "", $r19, $r10);	$r20 = r1.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.config.utils.SimpleReferenceCache referenceCache>;	virtualinvoke $r20.<org.apache.dubbo.config.utils.SimpleReferenceCache: void destroy(org.apache.dubbo.config.ReferenceConfigBase)>(r0);	throw $r10
;block_num 2