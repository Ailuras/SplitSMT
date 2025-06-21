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

(declare-sort var1550 0)
(declare-sort var2307 0)
(declare-sort var1927 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2307_isSupported/-1990264193 (ClassObject) Bool)
(declare-fun var1927-init () var1927)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1927 String) void)
(declare-const null-var1550 var1550)
(declare-const null-ClassObject ClassObject)
(declare-const var633 var1550) ; Statement: r1 := @parameter0: java.io.InputStream 
(assert (not (= var633 null-var1550)))
(declare-const var1787 ClassObject) ; Statement: r0 := @parameter1: java.lang.Class 
(assert (not (= var1787 null-ClassObject)))
(define-const var2022 Bool (var2307_isSupported/-1990264193 var1787)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils: boolean isSupported(java.lang.Class)>(r0) 
 ; Statement: if $z0 != 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils: org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils$SingleMessageMarshaller getMarshaller(java.lang.Class)>(r0) 
(assert (not (not (= (ite var2022 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var286 var1927 var1927-init) ; Statement: $r4 = new java.lang.IllegalArgumentException 
(define-const var1734 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1734)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1734!1 String)
(assert (= var1734!1 ""))
(assert true)
(define-const var3405 String (append/672562846 var1734!1 "This serialization only support google protobuf messages, but the actual input type is :")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("This serialization only support google protobuf messages, but the actual input type is :") 
(declare-const var1734!2 String)
(assert (= var1734!2 (str.++ var1734!1 "This serialization only support google protobuf messages, but the actual input type is :")))
(assert true)
(define-const var2622 String (getName/-1958580599 var1787)) ; Statement: $r6 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1882 String (append/672562846 var3405 var2622)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3405!1 String)
(assert (= var3405!1 (str.++ var3405 var2622)))
(assert true)
(define-const var1932 String (toString/-2075883882 var1882)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var286 var1932)) ; Statement: specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r9) 

(declare-const var286!1 var1927)
(declare-const var1932!1 String)
 ; Statement: throw $r4 
(check-sat)
; {var2307_isSupported/-1990264193=([java.lang.Class], boolean), var1927-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1550=java.io.InputStream, var633=r1, var1787=r0, var2307=org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils, var2022=$z0, var1927=java.lang.IllegalArgumentException, var286=$r4, var1734=$r5, var3405=$r7, var2622=$r6, var1882=$r8, var1932=$r9}
; {java.io.InputStream=var1550, r1=var633, r0=var1787, org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils=var2307, $z0=var2022, java.lang.IllegalArgumentException=var1927, $r4=var286, $r5=var1734, $r7=var3405, $r6=var2622, $r8=var1882, $r9=var1932}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.io.InputStream;	r0 := @parameter1: java.lang.Class;	$z0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils: boolean isSupported(java.lang.Class)>(r0);	if $z0 != 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils: org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils$SingleMessageMarshaller getMarshaller(java.lang.Class)>(r0);	$r4 = new java.lang.IllegalArgumentException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("This serialization only support google protobuf messages, but the actual input type is :");	$r6 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r9);	throw $r4
;block_num 2