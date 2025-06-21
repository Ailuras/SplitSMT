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

(declare-sort var3486 0)
(declare-sort var1714 0)
(declare-sort var2331 0)
(declare-sort var1585 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var1714) (Array Int Int))
(declare-fun var1585_sign/-1073723564 ((Array Int Int) String) String)
(declare-const null-String String)
(declare-const var2331-UTF_8 var1714)
(declare-const var3005 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3005 null-String)))
(declare-const var2097 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2097 null-String)))
(define-const var1502 var1714 var2331-UTF_8) ; Statement: $r1 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
(define-const var2286 (Array Int Int) (getBytes/-163691139 var3005 var1502)) ; Statement: $r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1) 
(define-const var1786 String (var1585_sign/-1073723564 var2286 var2097)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.auth.utils.SignatureUtils: java.lang.String sign(byte[],java.lang.String)>($r3, r2) 
 ; Statement: return $r4 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[]), var1585_sign/-1073723564=([byte[], java.lang.String], java.lang.String)}
; {var3005=r0, var3486=null_type, var2097=r2, var1714=java.nio.charset.Charset, var2331=java.nio.charset.StandardCharsets, var1502=$r1, var2286=$r3, var1585=org.apache.dubbo.auth.utils.SignatureUtils, var1786=$r4}
; {r0=var3005, null_type=var3486, r2=var2097, java.nio.charset.Charset=var1714, java.nio.charset.StandardCharsets=var2331, $r1=var1502, $r3=var2286, org.apache.dubbo.auth.utils.SignatureUtils=var1585, $r4=var1786}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$r1 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	$r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r1);	$r4 = staticinvoke <org.apache.dubbo.auth.utils.SignatureUtils: java.lang.String sign(byte[],java.lang.String)>($r3, r2);	return $r4
;block_num 1