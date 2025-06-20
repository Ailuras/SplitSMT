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

(declare-sort var2876 0)
(declare-sort var1386 0)
(declare-sort var1275 0)
(declare-sort var881 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1275_getVersion/310196261 () String)
(declare-fun var881_getLocalHost/-1653363627 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2876 var2876)
(declare-const null-String String)
(declare-const var3609 var2876) ; Statement: r11 := @this: org.apache.dubbo.common.logger.support.FailsafeLogger 
(assert (not (= var3609 null-var2876)))
(declare-const var2124 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2124 null-String)))
(define-const var2354 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2354)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2354!1 String)
(assert (= var2354!1 ""))
(assert true)
(define-const var95 String (append/672562846 var2354!1 " [DUBBO] ")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" [DUBBO] ") 
(declare-const var2354!2 String)
(assert (= var2354!2 (str.++ var2354!1 " [DUBBO] ")))
(assert true)
(define-const var800 String (append/672562846 var95 var2124)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var95!1 String)
(assert (= var95!1 (str.++ var95 var2124)))
(assert true)
(define-const var1374 String (append/672562846 var800 ", dubbo version: ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", dubbo version: ") 
(declare-const var800!1 String)
(assert (= var800!1 (str.++ var800 ", dubbo version: ")))
(define-const var3114 String var1275_getVersion/310196261) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>() 
(assert true)
(define-const var2340 String (append/672562846 var1374 var3114)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1374!1 String)
(assert (= var1374!1 (str.++ var1374 var3114)))
(assert true)
(define-const var1222 String (append/672562846 var2340 ", current host: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", current host: ") 
(declare-const var2340!1 String)
(assert (= var2340!1 (str.++ var2340 ", current host: ")))
(define-const var599 String var881_getLocalHost/-1653363627) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(assert true)
(define-const var87 String (append/672562846 var1222 var599)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1222!1 String)
(assert (= var1222!1 (str.++ var1222 var599)))
(assert true)
(define-const var3975 String (toString/-2075883882 var87)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1275_getVersion/310196261=([], java.lang.String), var881_getLocalHost/-1653363627=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2876=org.apache.dubbo.common.logger.support.FailsafeLogger, var3609=r11, var2124=r1, var1386=null_type, var2354=$r0, var95=$r2, var800=$r3, var1374=$r5, var1275=org.apache.dubbo.common.Version, var3114=$r4, var2340=$r6, var1222=$r8, var881=org.apache.dubbo.common.utils.NetUtils, var599=$r7, var87=$r9, var3975=$r10}
; {org.apache.dubbo.common.logger.support.FailsafeLogger=var2876, r11=var3609, r1=var2124, null_type=var1386, $r0=var2354, $r2=var95, $r3=var800, $r5=var1374, org.apache.dubbo.common.Version=var1275, $r4=var3114, $r6=var2340, $r8=var1222, org.apache.dubbo.common.utils.NetUtils=var881, $r7=var599, $r9=var87, $r10=var3975}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r11 := @this: org.apache.dubbo.common.logger.support.FailsafeLogger;	r1 := @parameter0: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" [DUBBO] ");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", dubbo version: ");	$r4 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", current host: ");	$r7 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1