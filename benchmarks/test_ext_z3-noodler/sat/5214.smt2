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

(declare-sort var90 0)
(declare-sort var1902 0)
(declare-sort var1434 0)
(declare-sort var620 0)
(declare-sort var3395 0)
(declare-sort var2022 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1434_directory/1826808414 (var1434) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2022_error/377575788 (var2022 String String String String var3395) void)
(declare-const null-var90 var90)
(declare-const null-var1902 var1902)
(declare-const null-var1434 var1434)
(declare-const null-String String)
(declare-const null-var3395 var3395)
(declare-const var90-logger var2022)
(declare-const var2192 var90) ; Statement: r8 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var2192 null-var90)))
(declare-const var938 var1902) ; Statement: r10 := @parameter0: java.util.Map 
(assert (not (= var938 null-var1902)))
(declare-const var2936 var1434) ; Statement: r1 := @parameter1: org.apache.dubbo.common.extension.LoadingStrategy 
(assert (not (= var2936 null-var1434)))
(declare-const var2093 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var2093 null-String)))
(define-const var1521 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1521)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1521!1 String)
(assert (= var1521!1 ""))
(define-const var3272 String (var1434_directory/1826808414 var2936)) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.common.extension.LoadingStrategy: java.lang.String directory()>() 
(assert true)
(define-const var945 String (append/672562846 var1521!1 var3272)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1521!2 String)
(assert (= var1521!2 (str.++ var1521!1 var3272)))
(assert true)
(define-const var949 String (append/672562846 var945 var2093)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var945!1 String)
(assert (= var945!1 (str.++ var945 var2093)))
(assert true)
(define-const var3014 String (toString/-2075883882 var949)) ; Statement: r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var200 var3395) ; Statement: $r25 := @caughtexception 
(assert (not (= var200 null-var3395)))
(define-const var437 var2022 var90-logger) ; Statement: $r27 = <org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var302 String String-init) ; Statement: $r26 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var302)) ; Statement: specialinvoke $r26.<java.lang.StringBuilder: void <init>()>() 
(declare-const var302!1 String)
(assert (= var302!1 ""))
(assert true)
(define-const var2519 String (append/672562846 var302!1 "Exception occurred when loading extension class (interface: ")) ; Statement: $r28 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception occurred when loading extension class (interface: ") 
(declare-const var302!2 String)
(assert (= var302!2 (str.++ var302!1 "Exception occurred when loading extension class (interface: ")))
(assert true)
(define-const var2793 String (append/672562846 var2519 var2093)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var2519!1 String)
(assert (= var2519!1 (str.++ var2519 var2093)))
(assert true)
(define-const var135 String (append/672562846 var2793 ", description file: ")) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", description file: ") 
(declare-const var2793!1 String)
(assert (= var2793!1 (str.++ var2793 ", description file: ")))
(assert true)
(define-const var3327 String (append/672562846 var135 var3014)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6) 
(declare-const var135!1 String)
(assert (= var135!1 (str.++ var135 var3014)))
(assert true)
(define-const var885 String (append/672562846 var3327 ").")) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(").") 
(declare-const var3327!1 String)
(assert (= var3327!1 (str.++ var3327 ").")))
(assert true)
(define-const var2531 String (toString/-2075883882 var885)) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2022_error/377575788 var437 "0-15" "" "" var2531 var200)) ; Statement: interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-15", "", "", $r33, $r25) 

(declare-const var437!1 var2022)
(declare-const var2630 String)
(declare-const var716 String)
(declare-const var716!1 String)
(declare-const var2531!1 String)
(declare-const var200!1 var3395)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1434_directory/1826808414=([org.apache.dubbo.common.extension.LoadingStrategy], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2022_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var90=org.apache.dubbo.common.extension.ExtensionLoader, var2192=r8, var1902=java.util.Map, var938=r10, var1434=org.apache.dubbo.common.extension.LoadingStrategy, var2936=r1, var2093=r3, var620=null_type, var1521=$r0, var3272=$r2, var945=$r4, var949=$r5, var3014=r6, var3395=java.lang.Throwable, var200=$r25, var2022=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var437=$r27, var302=$r26, var2519=$r28, var2793=$r29, var135=$r30, var3327=$r31, var885=$r32, var2531=$r33, var2630="0-15", var716=""}
; {org.apache.dubbo.common.extension.ExtensionLoader=var90, r8=var2192, java.util.Map=var1902, r10=var938, org.apache.dubbo.common.extension.LoadingStrategy=var1434, r1=var2936, r3=var2093, null_type=var620, $r0=var1521, $r2=var3272, $r4=var945, $r5=var949, r6=var3014, java.lang.Throwable=var3395, $r25=var200, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2022, $r27=var437, $r26=var302, $r28=var2519, $r29=var2793, $r30=var135, $r31=var3327, $r32=var885, $r33=var2531, "0-15"=var2630, ""=var716}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r8 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r10 := @parameter0: java.util.Map;	r1 := @parameter1: org.apache.dubbo.common.extension.LoadingStrategy;	r3 := @parameter2: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<org.apache.dubbo.common.extension.LoadingStrategy: java.lang.String directory()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r25 := @caughtexception;	$r27 = <org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r26 = new java.lang.StringBuilder;	specialinvoke $r26.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception occurred when loading extension class (interface: ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", description file: ");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(").");	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-15", "", "", $r33, $r25);	return
;block_num 3