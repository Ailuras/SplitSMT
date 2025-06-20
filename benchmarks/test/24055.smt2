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

(declare-sort var161 0)
(declare-sort var633 0)
(declare-sort var3342 0)
(declare-sort var2615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var633_isSupported/-1990264193 (ClassObject) Bool)
(declare-fun var2615-init () var2615)
(declare-fun <init>/-1735196448 (var2615 var3342) void)
(declare-const null-var161 var161)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3342 var3342)
(declare-const var3108 var161) ; Statement: r1 := @parameter0: java.io.InputStream 
(assert (not (= var3108 null-var161)))
(declare-const var2211 ClassObject) ; Statement: r0 := @parameter1: java.lang.Class 
(assert (not (= var2211 null-ClassObject)))
(define-const var836 Bool (var633_isSupported/-1990264193 var2211)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils: boolean isSupported(java.lang.Class)>(r0) 
 ; Statement: if $z0 != 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils: org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils$SingleMessageMarshaller getMarshaller(java.lang.Class)>(r0) 
(assert (not (not (= (ite var836 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(declare-const var3476 var3342) ; Statement: $r10 := @caughtexception 
(assert (not (= var3476 null-var3342)))
(define-const var2729 var2615 var2615-init) ; Statement: $r11 = new java.io.IOException 
(assert true)
;(assert (<init>/-1735196448 var2729 var3476)) ; Statement: specialinvoke $r11.<java.io.IOException: void <init>(java.lang.Throwable)>($r10) 

(declare-const var2729!1 var2615)
(declare-const var3476!1 var3342)
 ; Statement: throw $r11 
(check-sat)
; {var633_isSupported/-1990264193=([java.lang.Class], boolean), var2615-init=([], java.io.IOException), <init>/-1735196448=([java.io.IOException, java.lang.Throwable], void)}
; {var161=java.io.InputStream, var3108=r1, var2211=r0, var633=org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils, var836=$z0, var3342=java.lang.Throwable, var3476=$r10, var2615=java.io.IOException, var2729=$r11}
; {java.io.InputStream=var161, r1=var3108, r0=var2211, org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils=var633, $z0=var836, java.lang.Throwable=var3342, $r10=var3476, java.io.IOException=var2615, $r11=var2729}
;seq 
;cnt {}
;stmts r1 := @parameter0: java.io.InputStream;	r0 := @parameter1: java.lang.Class;	$z0 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils: boolean isSupported(java.lang.Class)>(r0);	if $z0 != 0 goto $r2 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils: org.apache.dubbo.rpc.protocol.tri.SingleProtobufUtils$SingleMessageMarshaller getMarshaller(java.lang.Class)>(r0);	$r10 := @caughtexception;	$r11 = new java.io.IOException;	specialinvoke $r11.<java.io.IOException: void <init>(java.lang.Throwable)>($r10);	throw $r11
;block_num 2