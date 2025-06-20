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

(declare-sort var2880 0)
(declare-sort var1631 0)
(declare-sort var3898 0)
(declare-sort var1339 0)
(declare-sort var1139 0)
(declare-sort var1030 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3898) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1139_warn/126438324 (var1139 String String String String var1339) void)
(declare-const null-var2880 var2880)
(declare-const null-String String)
(declare-const null-var3898 var3898)
(declare-const null-var1339 var1339)
(declare-const var1030-LOGGER var1139)
(declare-const var3313 var2880) ; Statement: r1 := @parameter0: java.util.function.BiConsumer 
(assert (not (= var3313 null-var2880)))
(declare-const var3667 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3667 null-String)))
(declare-const var1825 var3898) ; Statement: r0 := @parameter2: java.lang.Object 
(assert (not (= var1825 null-var3898)))
(assert true) ; Non Conditional
(define-const var3062 Bool false) ; Statement: $z0 = r0 instanceof java.lang.CharSequence 
(assert true) ; Non Conditional
 ; Statement: if $z0 != 0 goto $r27 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>() 
(assert (not (not (= (ite var3062 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3775 Bool false) ; Statement: $z1 = r0 instanceof java.lang.Number 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2450 var1339) ; Statement: $r19 := @caughtexception 
(assert (not (= var2450 null-var1339)))
(define-const var246 var1139 var1030-LOGGER) ; Statement: $r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var419 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var419)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var419!1 String)
(assert (= var419!1 ""))
(assert true)
(define-const var2772 String (append/672562846 var419!1 "Meet exception when convert single attachment key:")) ; Statement: $r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:") 
(declare-const var419!2 String)
(assert (= var419!2 (str.++ var419!1 "Meet exception when convert single attachment key:")))
(assert true)
(define-const var1475 String (append/672562846 var2772 var3667)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var2772!1 String)
(assert (= var2772!1 (str.++ var2772 var3667)))
(assert true)
(define-const var1569 String (append/672562846 var1475 " value=")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=") 
(declare-const var1475!1 String)
(assert (= var1475!1 (str.++ var1475 " value=")))
(assert true)
(define-const var2555 String (append/-1031950772 var1569 var1825)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var1569!1 String)
(assert (str.prefixof var1569 var1569!1))
(assert true)
(define-const var437 String (toString/-2075883882 var2555)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1139_warn/126438324 var246 "4-1" "" "" var437 var2450)) ; Statement: interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19) 

(declare-const var246!1 var1139)
(declare-const var1568 String)
(declare-const var3435 String)
(declare-const var3435!1 String)
(declare-const var437!1 String)
(declare-const var2450!1 var1339)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1139_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var2880=java.util.function.BiConsumer, var3313=r1, var3667=r2, var1631=null_type, var3898=java.lang.Object, var1825=r0, var3062=$z0, var3775=$z1, var1339=java.lang.Throwable, var2450=$r19, var1139=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1030=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils, var246=$r21, var419=$r20, var2772=$r22, var1475=$r23, var1569=$r24, var2555=$r25, var437=$r26, var1568="4-1", var3435=""}
; {java.util.function.BiConsumer=var2880, r1=var3313, r2=var3667, null_type=var1631, java.lang.Object=var3898, r0=var1825, $z0=var3062, $z1=var3775, java.lang.Throwable=var1339, $r19=var2450, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1139, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var1030, $r21=var246, $r20=var419, $r22=var2772, $r23=var1475, $r24=var1569, $r25=var2555, $r26=var437, "4-1"=var1568, ""=var3435}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.util.function.BiConsumer;	r2 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.Object;	$z0 = r0 instanceof java.lang.CharSequence;	if $z0 != 0 goto $r27 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>();	$z1 = r0 instanceof java.lang.Number;	$r19 := @caughtexception;	$r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19);	return
;block_num 6