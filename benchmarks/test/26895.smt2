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

(declare-sort var1132 0)
(declare-sort var765 0)
(declare-sort var1101 0)
(declare-sort var3369 0)
(declare-sort var1752 0)
(declare-sort var1029 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1101) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1752_warn/126438324 (var1752 String String String String var3369) void)
(declare-const null-var1132 var1132)
(declare-const null-String String)
(declare-const null-var1101 var1101)
(declare-const null-var3369 var3369)
(declare-const var1029-LOGGER var1752)
(declare-const var3815 var1132) ; Statement: r1 := @parameter0: java.util.function.BiConsumer 
(assert (not (= var3815 null-var1132)))
(declare-const var2646 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2646 null-String)))
(declare-const var2721 var1101) ; Statement: r0 := @parameter2: java.lang.Object 
(assert (not (= var2721 null-var1101)))
(assert true) ; Non Conditional
(define-const var2856 Bool false) ; Statement: $z0 = r0 instanceof java.lang.CharSequence 
(assert true) ; Non Conditional
 ; Statement: if $z0 != 0 goto $r27 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>() 
(assert (not (not (= (ite var2856 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(declare-const var2246 var3369) ; Statement: $r19 := @caughtexception 
(assert (not (= var2246 null-var3369)))
(define-const var3033 var1752 var1029-LOGGER) ; Statement: $r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var2175 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2175)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2175!1 String)
(assert (= var2175!1 ""))
(assert true)
(define-const var559 String (append/672562846 var2175!1 "Meet exception when convert single attachment key:")) ; Statement: $r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:") 
(declare-const var2175!2 String)
(assert (= var2175!2 (str.++ var2175!1 "Meet exception when convert single attachment key:")))
(assert true)
(define-const var3637 String (append/672562846 var559 var2646)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var559!1 String)
(assert (= var559!1 (str.++ var559 var2646)))
(assert true)
(define-const var2828 String (append/672562846 var3637 " value=")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=") 
(declare-const var3637!1 String)
(assert (= var3637!1 (str.++ var3637 " value=")))
(assert true)
(define-const var1099 String (append/-1031950772 var2828 var2721)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2828!1 String)
(assert (str.prefixof var2828 var2828!1))
(assert true)
(define-const var2885 String (toString/-2075883882 var1099)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1752_warn/126438324 var3033 "4-1" "" "" var2885 var2246)) ; Statement: interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19) 

(declare-const var3033!1 var1752)
(declare-const var1712 String)
(declare-const var1853 String)
(declare-const var1853!1 String)
(declare-const var2885!1 String)
(declare-const var2246!1 var3369)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1752_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1132=java.util.function.BiConsumer, var3815=r1, var2646=r2, var765=null_type, var1101=java.lang.Object, var2721=r0, var2856=$z0, var3369=java.lang.Throwable, var2246=$r19, var1752=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1029=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils, var3033=$r21, var2175=$r20, var559=$r22, var3637=$r23, var2828=$r24, var1099=$r25, var2885=$r26, var1712="4-1", var1853=""}
; {java.util.function.BiConsumer=var1132, r1=var3815, r2=var2646, null_type=var765, java.lang.Object=var1101, r0=var2721, $z0=var2856, java.lang.Throwable=var3369, $r19=var2246, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1752, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var1029, $r21=var3033, $r20=var2175, $r22=var559, $r23=var3637, $r24=var2828, $r25=var1099, $r26=var2885, "4-1"=var1712, ""=var1853}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.util.function.BiConsumer;	r2 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.Object;	$z0 = r0 instanceof java.lang.CharSequence;	if $z0 != 0 goto $r27 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>();	$r19 := @caughtexception;	$r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19);	return
;block_num 5