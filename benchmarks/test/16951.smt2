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

(declare-sort var1422 0)
(declare-sort var2544 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getBytes/-163691139 (String var1422) (Array Int Int))
(declare-const var2544-US_ASCII var1422)
(define-const var1180 String "data:") ; Statement: $r1 = "data:" 
(define-const var3262 var1422 var2544-US_ASCII) ; Statement: $r0 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset US_ASCII> 
(assert true)
(define-const var816 (Array Int Int) (getBytes/-163691139 var1180 var3262)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r0) 
(define-const var3049 (Array Int Int) var816) ; Statement: <org.apache.dubbo.remoting.http12.HttpConstants: byte[] SERVER_SENT_EVENT_DATA_PREFIX_BYTES> = $r2 
(define-const var3716 String "\n\n") ; Statement: $r4 = "\n\n" 
(define-const var2384 var1422 var2544-US_ASCII) ; Statement: $r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset US_ASCII> 
(assert true)
(define-const var1582 (Array Int Int) (getBytes/-163691139 var3716 var2384)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r3) 
(define-const var2350 (Array Int Int) var1582) ; Statement: <org.apache.dubbo.remoting.http12.HttpConstants: byte[] SERVER_SENT_EVENT_LF_BYTES> = $r5 
 ; Statement: return 
(check-sat)
; {getBytes/-163691139=([java.lang.String, java.nio.charset.Charset], byte[])}
; {var1180=$r1, var1422=java.nio.charset.Charset, var2544=java.nio.charset.StandardCharsets, var3262=$r0, var816=$r2, var3049=<org.apache.dubbo.remoting.http12.HttpConstants: byte[] SERVER_SENT_EVENT_DATA_PREFIX_BYTES>, var3716=$r4, var2384=$r3, var1582=$r5, var2350=<org.apache.dubbo.remoting.http12.HttpConstants: byte[] SERVER_SENT_EVENT_LF_BYTES>}
; {$r1=var1180, java.nio.charset.Charset=var1422, java.nio.charset.StandardCharsets=var2544, $r0=var3262, $r2=var816, <org.apache.dubbo.remoting.http12.HttpConstants: byte[] SERVER_SENT_EVENT_DATA_PREFIX_BYTES>=var3049, $r4=var3716, $r3=var2384, $r5=var1582, <org.apache.dubbo.remoting.http12.HttpConstants: byte[] SERVER_SENT_EVENT_LF_BYTES>=var2350}
;seq <java.lang.String: byte[] getBytes(java.nio.charset.Charset)>;	<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>
;cnt {"<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>": 2}
;stmts $r1 = "data:";	$r0 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset US_ASCII>;	$r2 = virtualinvoke $r1.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r0);	<org.apache.dubbo.remoting.http12.HttpConstants: byte[] SERVER_SENT_EVENT_DATA_PREFIX_BYTES> = $r2;	$r4 = "\n\n";	$r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset US_ASCII>;	$r5 = virtualinvoke $r4.<java.lang.String: byte[] getBytes(java.nio.charset.Charset)>($r3);	<org.apache.dubbo.remoting.http12.HttpConstants: byte[] SERVER_SENT_EVENT_LF_BYTES> = $r5;	return
;block_num 1