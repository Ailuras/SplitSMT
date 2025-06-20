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

(declare-sort var2533 0)
(declare-sort var766 0)
(declare-sort var166 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun var2533_encodeBase64/914940731 ((Array Int Int)) (Array Int Int))
(declare-fun <init>/-2015205558 (String (Array Int Int) var766) void)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var166-US_ASCII var766)
(declare-const var3146 (Array Int Int)) ; Statement: r1 := @parameter0: byte[] 
(assert (not (= var3146 null-__Array__Int__Int__)))
(define-const var3333 String String-init) ; Statement: $r0 = new java.lang.String 
(define-const var3935 (Array Int Int) (var2533_encodeBase64/914940731 var3146)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: byte[] encodeBase64(byte[])>(r1) 
(define-const var479 var766 var166-US_ASCII) ; Statement: $r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset US_ASCII> 
(assert true)
;(assert (<init>/-2015205558 var3333 var3935 var479)) ; Statement: specialinvoke $r0.<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>($r3, $r2) 

(declare-const var3333!1 String)
(declare-const var3935!1 (Array Int Int))
(declare-const var479!1 var766)
 ; Statement: return $r0 
(check-sat)
; {String-init=([], java.lang.String), var2533_encodeBase64/914940731=([byte[]], byte[]), <init>/-2015205558=([java.lang.String, byte[], java.nio.charset.Charset], void)}
; {var3146=r1, var3333=$r0, var2533=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils, var3935=$r3, var766=java.nio.charset.Charset, var166=java.nio.charset.StandardCharsets, var479=$r2}
; {r1=var3146, $r0=var3333, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var2533, $r3=var3935, java.nio.charset.Charset=var766, java.nio.charset.StandardCharsets=var166, $r2=var479}
;seq <java.lang.String: void <init>(byte[],java.nio.charset.Charset)>
;cnt {"<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>": 1}
;stmts r1 := @parameter0: byte[];	$r0 = new java.lang.String;	$r3 = staticinvoke <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: byte[] encodeBase64(byte[])>(r1);	$r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset US_ASCII>;	specialinvoke $r0.<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>($r3, $r2);	return $r0
;block_num 1