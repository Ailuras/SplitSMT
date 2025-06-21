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

(declare-sort var3777 0)
(declare-sort var959 0)
(declare-sort var844 0)
(declare-sort var2677 0)
(declare-sort var549 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUniqueServiceName/925035605 (var959) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var549_info/1294235139 (var549 String var844) void)
(declare-fun cast-from-var2677-to-var549 (var2677) var549)
(declare-const null-var3777 var3777)
(declare-const null-var959 var959)
(declare-const null-var844 var844)
(declare-const var3777-logger var2677)
(declare-const var3207 var3777) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer 
(assert (not (= var3207 null-var3777)))
(declare-const var1098 var959) ; Statement: r1 := @parameter0: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var1098 null-var959)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3072 var844) ; Statement: $r3 := @caughtexception 
(assert (not (= var3072 null-var844)))
(define-const var1097 var2677 var3777-logger) ; Statement: $r5 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3844 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3844)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3844!1 String)
(assert (= var3844!1 ""))
(assert true)
(define-const var472 String (append/672562846 var3844!1 "Failed to un-export service. Service Key: ")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to un-export service. Service Key: ") 
(declare-const var3844!2 String)
(assert (= var3844!2 (str.++ var3844!1 "Failed to un-export service. Service Key: ")))
(assert true)
(define-const var3370 String (getUniqueServiceName/925035605 var1098)) ; Statement: $r6 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String getUniqueServiceName()>() 
(assert true)
(define-const var2143 String (append/672562846 var472 var3370)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var472!1 String)
(assert (= var472!1 (str.++ var472 var3370)))
(assert true)
(define-const var2933 String (toString/-2075883882 var2143)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var549_info/1294235139 (cast-from-var2677-to-var549 var1097) var2933 var3072)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String,java.lang.Throwable)>($r9, $r3) 

(declare-const var1097!1 var2677)
(declare-const var2933!1 String)
(declare-const var3072!1 var844)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUniqueServiceName/925035605=([org.apache.dubbo.config.ServiceConfigBase], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var549_info/1294235139=([org.apache.dubbo.common.logger.Logger, java.lang.String, java.lang.Throwable], void), cast-from-var2677-to-var549=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var3777=org.apache.dubbo.config.deploy.DefaultModuleDeployer, var3207=r0, var959=org.apache.dubbo.config.ServiceConfigBase, var1098=r1, var844=java.lang.Throwable, var3072=$r3, var2677=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1097=$r5, var3844=$r4, var472=$r7, var3370=$r6, var2143=$r8, var2933=$r9, var549=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.config.deploy.DefaultModuleDeployer=var3777, r0=var3207, org.apache.dubbo.config.ServiceConfigBase=var959, r1=var1098, java.lang.Throwable=var844, $r3=var3072, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2677, $r5=var1097, $r4=var3844, $r7=var472, $r6=var3370, $r8=var2143, $r9=var2933, org.apache.dubbo.common.logger.Logger=var549}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer;	r1 := @parameter0: org.apache.dubbo.config.ServiceConfigBase;	$r3 := @caughtexception;	$r5 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to un-export service. Service Key: ");	$r6 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String getUniqueServiceName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String,java.lang.Throwable)>($r9, $r3);	return
;block_num 3