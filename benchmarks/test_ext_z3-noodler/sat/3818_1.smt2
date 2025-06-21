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

(declare-sort var1442 0)
(declare-sort var3785 0)
(declare-sort var3983 0)
(declare-sort var2698 0)
(declare-sort var9 0)
(declare-sort var1768 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getMessage/849299655 (var1768) String)
(declare-fun cast-from-var2698-to-var1768 (var2698) var1768)
(declare-fun var9_warn/126438324 (var9 String String String String var1768) void)
(declare-const null-var1442 var1442)
(declare-const null-var3785 var3785)
(declare-const null-String String)
(declare-const null-var2698 var2698)
(declare-const var1442-logger var9)
(declare-const var2402 var1442) ; Statement: r16 := @this: org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository 
(assert (not (= var2402 null-var1442)))
(declare-const var2932 var3785) ; Statement: r0 := @parameter0: java.util.concurrent.ExecutorService 
(assert (not (= var2932 null-var3785)))
(declare-const var1859 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var1859 null-String)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1472 var2698) ; Statement: $r3 := @caughtexception 
(assert (not (= var1472 null-var2698)))
(define-const var2816 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2816)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2816!1 String)
(assert (= var2816!1 ""))
(assert true)
(define-const var2624 String (append/672562846 var2816!1 "shutdown executor service [")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("shutdown executor service [") 
(declare-const var2816!2 String)
(assert (= var2816!2 (str.++ var2816!1 "shutdown executor service [")))
(assert true)
(define-const var495 String (append/672562846 var2624 var1859)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var2624!1 String)
(assert (= var2624!1 (str.++ var2624 var1859)))
(assert true)
(define-const var2984 String (append/672562846 var495 "] failed: ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] failed: ") 
(declare-const var495!1 String)
(assert (= var495!1 (str.++ var495 "] failed: ")))
(assert true)
(define-const var425 String (toString/-2075883882 var2984)) ; Statement: r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1188 var9 var1442-logger) ; Statement: $r11 = <org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2362 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2362)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2362!1 String)
(assert (= var2362!1 ""))
(assert true)
(define-const var424 String (append/672562846 var2362!1 var425)) ; Statement: $r13 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r9) 
(declare-const var2362!2 String)
(assert (= var2362!2 (str.++ var2362!1 var425)))
(assert true)
(define-const var836 String (getMessage/849299655 (cast-from-var2698-to-var1768 var1472))) ; Statement: $r12 = virtualinvoke $r3.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var896 String (append/672562846 var424 var836)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var424!1 String)
(assert (= var424!1 (str.++ var424 var836)))
(assert true)
(define-const var3483 String (toString/-2075883882 var896)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var9_warn/126438324 var1188 "0-17" "" "" var3483 (cast-from-var2698-to-var1768 var1472))) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-17", "", "", $r15, $r3) 

(declare-const var1188!1 var9)
(declare-const var1607 String)
(declare-const var33 String)
(declare-const var33!1 String)
(declare-const var3483!1 String)
(declare-const var1472!1 var2698)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2698-to-var1768=([java.lang.Exception], java.lang.Throwable), var9_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1442=org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository, var2402=r16, var3785=java.util.concurrent.ExecutorService, var2932=r0, var1859=r5, var3983=null_type, var2698=java.lang.Exception, var1472=$r3, var2816=$r4, var2624=$r6, var495=$r7, var2984=$r8, var425=r9, var9=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1188=$r11, var2362=$r10, var424=$r13, var1768=java.lang.Throwable, var836=$r12, var896=$r14, var3483=$r15, var1607="0-17", var33=""}
; {org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository=var1442, r16=var2402, java.util.concurrent.ExecutorService=var3785, r0=var2932, r5=var1859, null_type=var3983, java.lang.Exception=var2698, $r3=var1472, $r4=var2816, $r6=var2624, $r7=var495, $r8=var2984, r9=var425, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var9, $r11=var1188, $r10=var2362, $r13=var424, java.lang.Throwable=var1768, $r12=var836, $r14=var896, $r15=var3483, "0-17"=var1607, ""=var33}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r16 := @this: org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository;	r0 := @parameter0: java.util.concurrent.ExecutorService;	r5 := @parameter1: java.lang.String;	$r3 := @caughtexception;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("shutdown executor service [");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] failed: ");	r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r11 = <org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r9);	$r12 = virtualinvoke $r3.<java.lang.Exception: java.lang.String getMessage()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-17", "", "", $r15, $r3);	return
;block_num 3