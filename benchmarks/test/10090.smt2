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

(declare-sort var3103 0)
(declare-sort var47 0)
(declare-sort var95 0)
(declare-sort var24 0)
(declare-sort var1470 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getIdentifier/-338683473 (var1470) String)
(declare-fun cast-from-var3103-to-var1470 (var3103) var1470)
(declare-fun getMessage/849299655 (var95) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var24_error/377575788 (var24 String String String String var95) void)
(declare-const null-var3103 var3103)
(declare-const null-var47 var47)
(declare-const null-var95 var95)
(declare-const var3103-logger var24)
(declare-const var3854 var3103) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer 
(assert (not (= var3854 null-var3103)))
(declare-const var2517 var47) ; Statement: r1 := @parameter0: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var2517 null-var47)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1888 var95) ; Statement: $r3 := @caughtexception 
(assert (not (= var1888 null-var95)))
(define-const var1580 var24 var3103-logger) ; Statement: $r5 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3890 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3890)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3890!1 String)
(assert (= var3890!1 ""))
(assert true)
(define-const var3927 String (append/672562846 var3890!1 "Failed to async export service config: ")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to async export service config: ") 
(declare-const var3890!2 String)
(assert (= var3890!2 (str.++ var3890!1 "Failed to async export service config: ")))
(assert true)
(define-const var352 String (getIdentifier/-338683473 (cast-from-var3103-to-var1470 var3854))) ; Statement: $r6 = virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>() 
(assert true)
(define-const var3129 String (append/672562846 var3927 var352)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3927!1 String)
(assert (= var3927!1 (str.++ var3927 var352)))
(assert true)
(define-const var1661 String (append/672562846 var3129 " , catch error : ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , catch error : ") 
(declare-const var3129!1 String)
(assert (= var3129!1 (str.++ var3129 " , catch error : ")))
(assert true)
(define-const var3389 String (getMessage/849299655 var1888)) ; Statement: $r9 = virtualinvoke $r3.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3984 String (append/672562846 var1661 var3389)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1661!1 String)
(assert (= var1661!1 (str.++ var1661 var3389)))
(assert true)
(define-const var1877 String (toString/-2075883882 var3984)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var24_error/377575788 var1580 "5-9" "" "" var1877 var1888)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-9", "", "", $r12, $r3) 

(declare-const var1580!1 var24)
(declare-const var1268 String)
(declare-const var2529 String)
(declare-const var2529!1 String)
(declare-const var1877!1 String)
(declare-const var1888!1 var95)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getIdentifier/-338683473=([org.apache.dubbo.common.deploy.AbstractDeployer], java.lang.String), cast-from-var3103-to-var1470=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.common.deploy.AbstractDeployer), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var24_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var3103=org.apache.dubbo.config.deploy.DefaultModuleDeployer, var3854=r0, var47=org.apache.dubbo.config.ReferenceConfigBase, var2517=r1, var95=java.lang.Throwable, var1888=$r3, var24=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1580=$r5, var3890=$r4, var3927=$r7, var1470=org.apache.dubbo.common.deploy.AbstractDeployer, var352=$r6, var3129=$r8, var1661=$r10, var3389=$r9, var3984=$r11, var1877=$r12, var1268="5-9", var2529=""}
; {org.apache.dubbo.config.deploy.DefaultModuleDeployer=var3103, r0=var3854, org.apache.dubbo.config.ReferenceConfigBase=var47, r1=var2517, java.lang.Throwable=var95, $r3=var1888, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var24, $r5=var1580, $r4=var3890, $r7=var3927, org.apache.dubbo.common.deploy.AbstractDeployer=var1470, $r6=var352, $r8=var3129, $r10=var1661, $r9=var3389, $r11=var3984, $r12=var1877, "5-9"=var1268, ""=var2529}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer;	r1 := @parameter0: org.apache.dubbo.config.ReferenceConfigBase;	$r3 := @caughtexception;	$r5 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to async export service config: ");	$r6 = virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , catch error : ");	$r9 = virtualinvoke $r3.<java.lang.Throwable: java.lang.String getMessage()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-9", "", "", $r12, $r3);	return
;block_num 3