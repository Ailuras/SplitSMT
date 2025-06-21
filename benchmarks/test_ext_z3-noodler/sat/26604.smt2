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

(declare-sort var45 0)
(declare-sort var1008 0)
(declare-sort var3729 0)
(declare-sort var367 0)
(declare-sort var763 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var367) (Array Int Int))
(declare-fun decode/-1699352876 (var1008 (Array Int Int)) (Array Int Int))
(declare-const null-String String)
(declare-const var3729-BASE64_DECODER var1008)
(declare-const var763-US_ASCII var367)
(declare-const var2140 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2140 null-String)))
(define-const var1660 var1008 var3729-BASE64_DECODER) ; Statement: $r2 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: java.util.Base64$Decoder BASE64_DECODER> 
(define-const var3472 var367 var763-US_ASCII) ; Statement: $r1 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset US_ASCII> 
(assert true)
(define-const var3371 (Array Int Int) (getBytes/-163691139 var2140 var3472)) ; Statement: $r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(assert true)
(define-const var2450 (Array Int Int) (decode/-1699352876 var1660 var3371)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Base64$Decoder: byte[] decode(byte[])>($r3) 
 ; Statement: return $r4 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), decode/-1699352876=([java.util.Base64$Decoder, byte[]], byte[])}
; {var2140=r0, var45=null_type, var1008=java.util.Base64$Decoder, var3729=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils, var1660=$r2, var367=java.nio.charset.Charset, var763=java.nio.charset.StandardCharsets, var3472=$r1, var3371=$r3, var2450=$r4}
; {r0=var2140, null_type=var45, java.util.Base64$Decoder=var1008, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var3729, $r2=var1660, java.nio.charset.Charset=var367, java.nio.charset.StandardCharsets=var763, $r1=var3472, $r3=var3371, $r4=var2450}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r2 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: java.util.Base64$Decoder BASE64_DECODER>;	$r1 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset US_ASCII>;	$r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = virtualinvoke $r2.<java.util.Base64$Decoder: byte[] decode(byte[])>($r3);	return $r4
;block_num 1