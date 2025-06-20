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

(declare-sort var895 0)
(declare-sort var436 0)
(declare-sort var1999 0)
(declare-sort var3795 0)
(declare-sort var276 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getIdentifier/-338683473 (var276) String)
(declare-fun cast-from-var895-to-var276 (var895) var276)
(declare-fun getMessage/849299655 (var1999) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3795_error/377575788 (var3795 String String String String var1999) void)
(declare-const null-var895 var895)
(declare-const null-var436 var436)
(declare-const null-var1999 var1999)
(declare-const var895-logger var3795)
(declare-const var3688 var895) ; Statement: r1 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer 
(assert (not (= var3688 null-var895)))
(declare-const var3643 var436) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var3643 null-var436)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3763 var1999) ; Statement: $r3 := @caughtexception 
(assert (not (= var3763 null-var1999)))
(define-const var47 var3795 var895-logger) ; Statement: $r5 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3420 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3420)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3420!1 String)
(assert (= var3420!1 ""))
(assert true)
(define-const var3708 String (append/672562846 var3420!1 "Failed to async export service config: ")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to async export service config: ") 
(declare-const var3420!2 String)
(assert (= var3420!2 (str.++ var3420!1 "Failed to async export service config: ")))
(assert true)
(define-const var2103 String (getIdentifier/-338683473 (cast-from-var895-to-var276 var3688))) ; Statement: $r6 = virtualinvoke r1.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>() 
(assert true)
(define-const var3031 String (append/672562846 var3708 var2103)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3708!1 String)
(assert (= var3708!1 (str.++ var3708 var2103)))
(assert true)
(define-const var482 String (append/672562846 var3031 " , catch error : ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , catch error : ") 
(declare-const var3031!1 String)
(assert (= var3031!1 (str.++ var3031 " , catch error : ")))
(assert true)
(define-const var287 String (getMessage/849299655 var3763)) ; Statement: $r9 = virtualinvoke $r3.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3949 String (append/672562846 var482 var287)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var482!1 String)
(assert (= var482!1 (str.++ var482 var287)))
(assert true)
(define-const var437 String (toString/-2075883882 var3949)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3795_error/377575788 var47 "5-9" "" "" var437 var3763)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-9", "", "", $r12, $r3) 

(declare-const var47!1 var3795)
(declare-const var933 String)
(declare-const var1597 String)
(declare-const var1597!1 String)
(declare-const var437!1 String)
(declare-const var3763!1 var1999)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getIdentifier/-338683473=([org.apache.dubbo.common.deploy.AbstractDeployer], java.lang.String), cast-from-var895-to-var276=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.common.deploy.AbstractDeployer), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3795_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var895=org.apache.dubbo.config.deploy.DefaultModuleDeployer, var3688=r1, var436=org.apache.dubbo.config.ServiceConfigBase, var3643=r0, var1999=java.lang.Throwable, var3763=$r3, var3795=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var47=$r5, var3420=$r4, var3708=$r7, var276=org.apache.dubbo.common.deploy.AbstractDeployer, var2103=$r6, var3031=$r8, var482=$r10, var287=$r9, var3949=$r11, var437=$r12, var933="5-9", var1597=""}
; {org.apache.dubbo.config.deploy.DefaultModuleDeployer=var895, r1=var3688, org.apache.dubbo.config.ServiceConfigBase=var436, r0=var3643, java.lang.Throwable=var1999, $r3=var3763, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3795, $r5=var47, $r4=var3420, $r7=var3708, org.apache.dubbo.common.deploy.AbstractDeployer=var276, $r6=var2103, $r8=var3031, $r10=var482, $r9=var287, $r11=var3949, $r12=var437, "5-9"=var933, ""=var1597}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer;	r0 := @parameter0: org.apache.dubbo.config.ServiceConfigBase;	$r3 := @caughtexception;	$r5 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to async export service config: ");	$r6 = virtualinvoke r1.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" , catch error : ");	$r9 = virtualinvoke $r3.<java.lang.Throwable: java.lang.String getMessage()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-9", "", "", $r12, $r3);	return
;block_num 3