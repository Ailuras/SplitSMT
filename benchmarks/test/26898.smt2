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

(declare-sort var2031 0)
(declare-sort var1010 0)
(declare-sort var1135 0)
(declare-sort var389 0)
(declare-sort var752 0)
(declare-sort var2683 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-522406933 (var1135) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1135) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var752_warn/126438324 (var752 String String String String var389) void)
(declare-const null-var2031 var2031)
(declare-const null-String String)
(declare-const null-var1135 var1135)
(declare-const null-var389 var389)
(declare-const var2683-LOGGER var752)
(declare-const var1830 var2031) ; Statement: r1 := @parameter0: java.util.function.BiConsumer 
(assert (not (= var1830 null-var2031)))
(declare-const var1647 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1647 null-String)))
(declare-const var3004 var1135) ; Statement: r0 := @parameter2: java.lang.Object 
(assert (not (= var3004 null-var1135)))
(assert true) ; Non Conditional
(define-const var1613 Bool false) ; Statement: $z0 = r0 instanceof java.lang.CharSequence 
(assert true) ; Non Conditional
 ; Statement: if $z0 != 0 goto $r27 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>() 
(assert (not (= (ite var1613 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var2556 String (toString/-522406933 var3004)) ; Statement: $r27 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var178 var389) ; Statement: $r19 := @caughtexception 
(assert (not (= var178 null-var389)))
(define-const var1120 var752 var2683-LOGGER) ; Statement: $r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var1823 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1823)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1823!1 String)
(assert (= var1823!1 ""))
(assert true)
(define-const var1992 String (append/672562846 var1823!1 "Meet exception when convert single attachment key:")) ; Statement: $r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:") 
(declare-const var1823!2 String)
(assert (= var1823!2 (str.++ var1823!1 "Meet exception when convert single attachment key:")))
(assert true)
(define-const var299 String (append/672562846 var1992 var1647)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1992!1 String)
(assert (= var1992!1 (str.++ var1992 var1647)))
(assert true)
(define-const var1490 String (append/672562846 var299 " value=")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=") 
(declare-const var299!1 String)
(assert (= var299!1 (str.++ var299 " value=")))
(assert true)
(define-const var197 String (append/-1031950772 var1490 var3004)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var1490!1 String)
(assert (str.prefixof var1490 var1490!1))
(assert true)
(define-const var3354 String (toString/-2075883882 var197)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var752_warn/126438324 var1120 "4-1" "" "" var3354 var178)) ; Statement: interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19) 

(declare-const var1120!1 var752)
(declare-const var2364 String)
(declare-const var3063 String)
(declare-const var3063!1 String)
(declare-const var3354!1 String)
(declare-const var178!1 var389)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {toString/-522406933=([java.lang.Object], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var752_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var2031=java.util.function.BiConsumer, var1830=r1, var1647=r2, var1010=null_type, var1135=java.lang.Object, var3004=r0, var1613=$z0, var2556=$r27, var389=java.lang.Throwable, var178=$r19, var752=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2683=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils, var1120=$r21, var1823=$r20, var1992=$r22, var299=$r23, var1490=$r24, var197=$r25, var3354=$r26, var2364="4-1", var3063=""}
; {java.util.function.BiConsumer=var2031, r1=var1830, r2=var1647, null_type=var1010, java.lang.Object=var1135, r0=var3004, $z0=var1613, $r27=var2556, java.lang.Throwable=var389, $r19=var178, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var752, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var2683, $r21=var1120, $r20=var1823, $r22=var1992, $r23=var299, $r24=var1490, $r25=var197, $r26=var3354, "4-1"=var2364, ""=var3063}
;seq <java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.util.function.BiConsumer;	r2 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.Object;	$z0 = r0 instanceof java.lang.CharSequence;	if $z0 != 0 goto $r27 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>();	$r27 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>();	$r19 := @caughtexception;	$r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19);	return
;block_num 6