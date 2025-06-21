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

(declare-sort var2866 0)
(declare-sort var961 0)
(declare-sort var1108 0)
(declare-sort var587 0)
(declare-sort var2510 0)
(declare-sort var619 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var619) String)
(declare-fun cast-from-var587-to-var619 (var587) var619)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2510_info/484404803 (var2510 String) void)
(declare-const null-var2866 var2866)
(declare-const null-String String)
(declare-const null-var1108 var1108)
(declare-const null-var587 var587)
(declare-const var2866-logger var2510)
(declare-const var2084 var2866) ; Statement: r0 := @this: org.apache.dubbo.common.status.reporter.FrameworkStatusReportService 
(assert (not (= var2084 null-var2866)))
(declare-const var3151 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var3151 null-String)))
(declare-const var3093 var1108) ; Statement: r6 := @parameter1: java.lang.Object 
(assert (not (= var3093 null-var1108)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var934 var587) ; Statement: $r7 := @caughtexception 
(assert (not (= var934 null-var587)))
(define-const var574 var2510 var2866-logger) ; Statement: $r9 = <org.apache.dubbo.common.status.reporter.FrameworkStatusReportService: org.apache.dubbo.common.logger.Logger logger> 
(define-const var1596 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1596)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1596!1 String)
(assert (= var1596!1 ""))
(assert true)
(define-const var788 String (append/672562846 var1596!1 "Report ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Report ") 
(declare-const var1596!2 String)
(assert (= var1596!2 (str.++ var1596!1 "Report ")))
(assert true)
(define-const var551 String (append/672562846 var788 var3151)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var788!1 String)
(assert (= var788!1 (str.++ var788 var3151)))
(assert true)
(define-const var3490 String (append/672562846 var551 " status failed because of ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" status failed because of ") 
(declare-const var551!1 String)
(assert (= var551!1 (str.++ var551 " status failed because of ")))
(assert true)
(define-const var756 String (getMessage/849299655 (cast-from-var587-to-var619 var934))) ; Statement: $r12 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var512 String (append/672562846 var3490 var756)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var3490!1 String)
(assert (= var3490!1 (str.++ var3490 var756)))
(assert true)
(define-const var3765 String (toString/-2075883882 var512)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2510_info/484404803 var574 var3765)) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r15) 

(declare-const var574!1 var2510)
(declare-const var3765!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var587-to-var619=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2510_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void)}
; {var2866=org.apache.dubbo.common.status.reporter.FrameworkStatusReportService, var2084=r0, var3151=r5, var961=null_type, var1108=java.lang.Object, var3093=r6, var587=java.lang.Exception, var934=$r7, var2510=org.apache.dubbo.common.logger.Logger, var574=$r9, var1596=$r8, var788=$r10, var551=$r11, var3490=$r13, var619=java.lang.Throwable, var756=$r12, var512=$r14, var3765=$r15}
; {org.apache.dubbo.common.status.reporter.FrameworkStatusReportService=var2866, r0=var2084, r5=var3151, null_type=var961, java.lang.Object=var1108, r6=var3093, java.lang.Exception=var587, $r7=var934, org.apache.dubbo.common.logger.Logger=var2510, $r9=var574, $r8=var1596, $r10=var788, $r11=var551, $r13=var3490, java.lang.Throwable=var619, $r12=var756, $r14=var512, $r15=var3765}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.status.reporter.FrameworkStatusReportService;	r5 := @parameter0: java.lang.String;	r6 := @parameter1: java.lang.Object;	$r7 := @caughtexception;	$r9 = <org.apache.dubbo.common.status.reporter.FrameworkStatusReportService: org.apache.dubbo.common.logger.Logger logger>;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Report ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" status failed because of ");	$r12 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r9.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r15);	return
;block_num 3