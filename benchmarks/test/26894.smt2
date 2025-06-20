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

(declare-sort var1378 0)
(declare-sort var2724 0)
(declare-sort var3023 0)
(declare-sort var631 0)
(declare-sort var284 0)
(declare-sort var1403 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3023) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var284_warn/126438324 (var284 String String String String var631) void)
(declare-const null-var1378 var1378)
(declare-const null-String String)
(declare-const null-var3023 var3023)
(declare-const null-var631 var631)
(declare-const var1403-LOGGER var284)
(declare-const var293 var1378) ; Statement: r1 := @parameter0: java.util.function.BiConsumer 
(assert (not (= var293 null-var1378)))
(declare-const var2642 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2642 null-String)))
(declare-const var260 var3023) ; Statement: r0 := @parameter2: java.lang.Object 
(assert (not (= var260 null-var3023)))
(assert true) ; Non Conditional
(define-const var1817 Bool false) ; Statement: $z0 = r0 instanceof java.lang.CharSequence 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3959 var631) ; Statement: $r19 := @caughtexception 
(assert (not (= var3959 null-var631)))
(define-const var246 var284 var1403-LOGGER) ; Statement: $r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var1566 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1566)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1566!1 String)
(assert (= var1566!1 ""))
(assert true)
(define-const var443 String (append/672562846 var1566!1 "Meet exception when convert single attachment key:")) ; Statement: $r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:") 
(declare-const var1566!2 String)
(assert (= var1566!2 (str.++ var1566!1 "Meet exception when convert single attachment key:")))
(assert true)
(define-const var101 String (append/672562846 var443 var2642)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var443!1 String)
(assert (= var443!1 (str.++ var443 var2642)))
(assert true)
(define-const var792 String (append/672562846 var101 " value=")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=") 
(declare-const var101!1 String)
(assert (= var101!1 (str.++ var101 " value=")))
(assert true)
(define-const var3145 String (append/-1031950772 var792 var260)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var792!1 String)
(assert (str.prefixof var792 var792!1))
(assert true)
(define-const var2301 String (toString/-2075883882 var3145)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var284_warn/126438324 var246 "4-1" "" "" var2301 var3959)) ; Statement: interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19) 

(declare-const var246!1 var284)
(declare-const var2461 String)
(declare-const var2584 String)
(declare-const var2584!1 String)
(declare-const var2301!1 String)
(declare-const var3959!1 var631)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var284_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1378=java.util.function.BiConsumer, var293=r1, var2642=r2, var2724=null_type, var3023=java.lang.Object, var260=r0, var1817=$z0, var631=java.lang.Throwable, var3959=$r19, var284=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1403=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils, var246=$r21, var1566=$r20, var443=$r22, var101=$r23, var792=$r24, var3145=$r25, var2301=$r26, var2461="4-1", var2584=""}
; {java.util.function.BiConsumer=var1378, r1=var293, r2=var2642, null_type=var2724, java.lang.Object=var3023, r0=var260, $z0=var1817, java.lang.Throwable=var631, $r19=var3959, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var284, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var1403, $r21=var246, $r20=var1566, $r22=var443, $r23=var101, $r24=var792, $r25=var3145, $r26=var2301, "4-1"=var2461, ""=var2584}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.util.function.BiConsumer;	r2 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.Object;	$z0 = r0 instanceof java.lang.CharSequence;	$r19 := @caughtexception;	$r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19);	return
;block_num 4