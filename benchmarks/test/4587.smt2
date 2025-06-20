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

(declare-sort var3296 0)
(declare-sort var700 0)
(declare-sort var367 0)
(declare-sort var1985 0)
(declare-sort var72 0)
(declare-sort var2439 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getMessage/849299655 (var2439) String)
(declare-fun cast-from-var1985-to-var2439 (var1985) var2439)
(declare-fun var72_warn/126438324 (var72 String String String String var2439) void)
(declare-const null-var3296 var3296)
(declare-const null-var700 var700)
(declare-const null-String String)
(declare-const null-var1985 var1985)
(declare-const var3296-logger var72)
(declare-const var2798 var3296) ; Statement: r14 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository 
(assert (not (= var2798 null-var3296)))
(declare-const var2008 var700) ; Statement: r0 := @parameter0: java.util.concurrent.ExecutorService 
(assert (not (= var2008 null-var700)))
(declare-const var1707 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var1707 null-String)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1397 var1985) ; Statement: $r1 := @caughtexception 
(assert (not (= var1397 null-var1985)))
(define-const var1230 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1230)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1230!1 String)
(assert (= var1230!1 ""))
(assert true)
(define-const var182 String (append/672562846 var1230!1 "shutdown executor service [")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("shutdown executor service [") 
(declare-const var1230!2 String)
(assert (= var1230!2 (str.++ var1230!1 "shutdown executor service [")))
(assert true)
(define-const var2123 String (append/672562846 var182 var1707)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var182!1 String)
(assert (= var182!1 (str.++ var182 var1707)))
(assert true)
(define-const var1623 String (append/672562846 var2123 "] failed: ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] failed: ") 
(declare-const var2123!1 String)
(assert (= var2123!1 (str.++ var2123 "] failed: ")))
(assert true)
(define-const var3724 String (toString/-2075883882 var1623)) ; Statement: r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1322 var72 var3296-logger) ; Statement: $r9 = <org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var205 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var205)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var205!1 String)
(assert (= var205!1 ""))
(assert true)
(define-const var289 String (append/672562846 var205!1 var3724)) ; Statement: $r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var205!2 String)
(assert (= var205!2 (str.++ var205!1 var3724)))
(assert true)
(define-const var2073 String (getMessage/849299655 (cast-from-var1985-to-var2439 var1397))) ; Statement: $r10 = virtualinvoke $r1.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var2022 String (append/672562846 var289 var2073)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var289!1 String)
(assert (= var289!1 (str.++ var289 var2073)))
(assert true)
(define-const var3985 String (toString/-2075883882 var2022)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var72_warn/126438324 var1322 "0-17" "" "" var3985 (cast-from-var1985-to-var2439 var1397))) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-17", "", "", $r13, $r1) 

(declare-const var1322!1 var72)
(declare-const var3000 String)
(declare-const var1361 String)
(declare-const var1361!1 String)
(declare-const var3985!1 String)
(declare-const var1397!1 var1985)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var1985-to-var2439=([java.lang.Exception], java.lang.Throwable), var72_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var3296=org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, var2798=r14, var700=java.util.concurrent.ExecutorService, var2008=r0, var1707=r3, var367=null_type, var1985=java.lang.Exception, var1397=$r1, var1230=$r2, var182=$r4, var2123=$r5, var1623=$r6, var3724=r7, var72=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1322=$r9, var205=$r8, var289=$r11, var2439=java.lang.Throwable, var2073=$r10, var2022=$r12, var3985=$r13, var3000="0-17", var1361=""}
; {org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository=var3296, r14=var2798, java.util.concurrent.ExecutorService=var700, r0=var2008, r3=var1707, null_type=var367, java.lang.Exception=var1985, $r1=var1397, $r2=var1230, $r4=var182, $r5=var2123, $r6=var1623, r7=var3724, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var72, $r9=var1322, $r8=var205, $r11=var289, java.lang.Throwable=var2439, $r10=var2073, $r12=var2022, $r13=var3985, "0-17"=var3000, ""=var1361}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r14 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository;	r0 := @parameter0: java.util.concurrent.ExecutorService;	r3 := @parameter1: java.lang.String;	$r1 := @caughtexception;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("shutdown executor service [");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] failed: ");	r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = <org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r10 = virtualinvoke $r1.<java.lang.Exception: java.lang.String getMessage()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-17", "", "", $r13, $r1);	return
;block_num 3