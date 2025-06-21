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

(declare-sort var3755 0)
(declare-sort var1211 0)
(declare-sort var1752 0)
(declare-sort var1134 0)
(declare-sort var1631 0)
(declare-sort var3903 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/1565923212 (var3755) var1134)
(declare-fun var1752_getObjectAttachmentWithoutConvert/-2125165309 (var1752 String) var3903)
(declare-fun cast-from-var3903-to-String (var3903) String)
(declare-fun var1134_access$400/-558230215 (Int String String String) String)
(declare-fun var1631-init () var1631)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-2142452957 (var1631 var1211 String) void)
(declare-const null-var3755 var3755)
(declare-const null-var1211 var1211)
(declare-const null-var1752 var1752)
(declare-const null-var1631 var1631)
(declare-const var1123 var3755) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1 
(assert (not (= var1123 null-var3755)))
(declare-const var2242 var1211) ; Statement: r1 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2242 null-var1211)))
(declare-const var381 var1752) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var381 null-var1752)))
(define-const var289 var1134 (this$0/1565923212 var1123)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol this$0> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3300 var1631) ; Statement: $r4 := @caughtexception 
(assert (not (= var3300 null-var1631)))
(define-const var2627 var3903 (var1752_getObjectAttachmentWithoutConvert/-2125165309 var381 "path")) ; Statement: $r5 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("path") 
(define-const var428 String (cast-from-var3903-to-String var2627)) ; Statement: $r10 = (java.lang.String) $r5 
(define-const var2904 var3903 (var1752_getObjectAttachmentWithoutConvert/-2125165309 var381 "version")) ; Statement: $r6 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version") 
(define-const var3160 String (cast-from-var3903-to-String var2904)) ; Statement: $r9 = (java.lang.String) $r6 
(define-const var3945 var3903 (var1752_getObjectAttachmentWithoutConvert/-2125165309 var381 "group")) ; Statement: $r7 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(define-const var86 String (cast-from-var3903-to-String var3945)) ; Statement: $r8 = (java.lang.String) $r7 
(define-const var1693 String (var1134_access$400/-558230215 0 var428 var3160 var86)) ; Statement: r11 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.lang.String access$400(int,java.lang.String,java.lang.String,java.lang.String)>(0, $r10, $r9, $r8) 
(define-const var989 var1631 var1631-init) ; Statement: $r12 = new org.apache.dubbo.remoting.RemotingException 
(define-const var2810 String String-init) ; Statement: $r13 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2810)) ; Statement: specialinvoke $r13.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2810!1 String)
(assert (= var2810!1 ""))
(assert true)
(define-const var1410 String (append/672562846 var2810!1 "The stub service[")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The stub service[") 
(declare-const var2810!2 String)
(assert (= var2810!2 (str.++ var2810!1 "The stub service[")))
(assert true)
(define-const var1907 String (append/672562846 var1410 var1693)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11) 
(declare-const var1410!1 String)
(assert (= var1410!1 (str.++ var1410 var1693)))
(assert true)
(define-const var3672 String (append/672562846 var1907 "] is not found, it may not be exported yet")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] is not found, it may not be exported yet") 
(declare-const var1907!1 String)
(assert (= var1907!1 (str.++ var1907 "] is not found, it may not be exported yet")))
(assert true)
(define-const var3843 String (toString/-2075883882 var3672)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-2142452957 var989 var2242 var3843)) ; Statement: specialinvoke $r12.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r1, $r17) 

(declare-const var989!1 var1631)
(declare-const var2242!1 var1211)
(declare-const var3843!1 String)
 ; Statement: throw $r12 
(check-sat)
; {this$0/1565923212=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1], org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol), var1752_getObjectAttachmentWithoutConvert/-2125165309=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.Object), cast-from-var3903-to-String=([java.lang.Object], java.lang.String), var1134_access$400/-558230215=([int, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var1631-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-2142452957=([org.apache.dubbo.remoting.RemotingException, org.apache.dubbo.remoting.Channel, java.lang.String], void)}
; {var3755=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1, var1123=r0, var1211=org.apache.dubbo.remoting.Channel, var2242=r1, var1752=org.apache.dubbo.rpc.Invocation, var381=r2, var1134=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var289=$r3, var1631=org.apache.dubbo.remoting.RemotingException, var3300=$r4, var3903=java.lang.Object, var2627=$r5, var428=$r10, var2904=$r6, var3160=$r9, var3945=$r7, var86=$r8, var1693=r11, var989=$r12, var2810=$r13, var1410=$r14, var1907=$r15, var3672=$r16, var3843=$r17}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1=var3755, r0=var1123, org.apache.dubbo.remoting.Channel=var1211, r1=var2242, org.apache.dubbo.rpc.Invocation=var1752, r2=var381, org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var1134, $r3=var289, org.apache.dubbo.remoting.RemotingException=var1631, $r4=var3300, java.lang.Object=var3903, $r5=var2627, $r10=var428, $r6=var2904, $r9=var3160, $r7=var3945, $r8=var86, r11=var1693, $r12=var989, $r13=var2810, $r14=var1410, $r15=var1907, $r16=var3672, $r17=var3843}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1;	r1 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r3 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol this$0>;	$r4 := @caughtexception;	$r5 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("path");	$r10 = (java.lang.String) $r5;	$r6 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version");	$r9 = (java.lang.String) $r6;	$r7 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r8 = (java.lang.String) $r7;	r11 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.lang.String access$400(int,java.lang.String,java.lang.String,java.lang.String)>(0, $r10, $r9, $r8);	$r12 = new org.apache.dubbo.remoting.RemotingException;	$r13 = new java.lang.StringBuilder;	specialinvoke $r13.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("The stub service[");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] is not found, it may not be exported yet");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r12.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r1, $r17);	throw $r12
;block_num 2