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

(declare-sort var1038 0)
(declare-sort var329 0)
(declare-sort var1927 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun logger/2113415684 (var1038) var1927)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var329) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1927_warn/126438324 (var1927 String String String String var329) void)
(declare-const null-var1038 var1038)
(declare-const null-var329 var329)
(declare-const var2199 var1038) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.ReferenceCountInvokerWrapper 
(assert (not (= var2199 null-var1038)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var5 var329) ; Statement: $r24 := @caughtexception 
(assert (not (= var5 null-var329)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3268 var329) ; Statement: $r16 := @caughtexception 
(assert (not (= var3268 null-var329)))
(define-const var3158 var1927 (logger/2113415684 var2199)) ; Statement: $r18 = r0.<org.apache.dubbo.rpc.protocol.ReferenceCountInvokerWrapper: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2580 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2580)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2580!1 String)
(assert (= var2580!1 ""))
(assert true)
(define-const var3652 String (append/672562846 var2580!1 "Unexpected error occurred when releasing write lock, cause: ")) ; Statement: $r20 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected error occurred when releasing write lock, cause: ") 
(declare-const var2580!2 String)
(assert (= var2580!2 (str.++ var2580!1 "Unexpected error occurred when releasing write lock, cause: ")))
(assert true)
(define-const var3381 String (getMessage/849299655 var3268)) ; Statement: $r19 = virtualinvoke $r16.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var2768 String (append/672562846 var3652 var3381)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var3652!1 String)
(assert (= var3652!1 (str.++ var3652 var3381)))
(assert true)
(define-const var3879 String (toString/-2075883882 var2768)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1927_warn/126438324 var3158 "4-16" "" "" var3879 var3268)) ; Statement: interfaceinvoke $r18.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-16", "", "", $r22, $r16) 

(declare-const var3158!1 var1927)
(declare-const var105 String)
(declare-const var1350 String)
(declare-const var1350!1 String)
(declare-const var3879!1 String)
(declare-const var3268!1 var329)
(assert true) ; Non Conditional
 ; Statement: throw $r24 
(check-sat)
; {logger/2113415684=([org.apache.dubbo.rpc.protocol.ReferenceCountInvokerWrapper], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1927_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1038=org.apache.dubbo.rpc.protocol.ReferenceCountInvokerWrapper, var2199=r0, var329=java.lang.Throwable, var5=$r24, var3268=$r16, var1927=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3158=$r18, var2580=$r17, var3652=$r20, var3381=$r19, var2768=$r21, var3879=$r22, var105="4-16", var1350=""}
; {org.apache.dubbo.rpc.protocol.ReferenceCountInvokerWrapper=var1038, r0=var2199, java.lang.Throwable=var329, $r24=var5, $r16=var3268, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1927, $r18=var3158, $r17=var2580, $r20=var3652, $r19=var3381, $r21=var2768, $r22=var3879, "4-16"=var105, ""=var1350}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.ReferenceCountInvokerWrapper;	$r24 := @caughtexception;	$r16 := @caughtexception;	$r18 = r0.<org.apache.dubbo.rpc.protocol.ReferenceCountInvokerWrapper: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r20 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected error occurred when releasing write lock, cause: ");	$r19 = virtualinvoke $r16.<java.lang.Throwable: java.lang.String getMessage()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r18.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-16", "", "", $r22, $r16);	throw $r24
;block_num 4