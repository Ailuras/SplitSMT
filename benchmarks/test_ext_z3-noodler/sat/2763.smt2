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

(declare-sort var3813 0)
(declare-sort var2795 0)
(declare-sort var2797 0)
(declare-sort var1841 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun var2795_readBytes/1188925698 (var3813) (Array Int Int))
(declare-fun <init>/-2015205558 (String (Array Int Int) var2797) void)
(declare-const null-var3813 var3813)
(declare-const var1841-UTF_8 var2797)
(declare-const var1891 var3813) ; Statement: r1 := @parameter0: java.io.InputStream 
(assert (not (= var1891 null-var3813)))
(define-const var1372 String String-init) ; Statement: $r0 = new java.lang.String 
(define-const var3702 (Array Int Int) (var2795_readBytes/1188925698 var1891)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.io.StreamUtils: byte[] readBytes(java.io.InputStream)>(r1) 
(define-const var2662 var2797 var1841-UTF_8) ; Statement: $r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8> 
(assert true)
;(assert (<init>/-2015205558 var1372 var3702 var2662)) ; Statement: specialinvoke $r0.<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>($r3, $r2) 

(declare-const var1372!1 String)
(declare-const var3702!1 (Array Int Int))
(declare-const var2662!1 var2797)
 ; Statement: return $r0 
(check-sat)
; {String-init=([], java.lang.String), var2795_readBytes/1188925698=([java.io.InputStream], byte[]), <init>/-2015205558=([java.lang.String, byte[], java.nio.charset.Charset], void)}
; {var3813=java.io.InputStream, var1891=r1, var1372=$r0, var2795=org.apache.dubbo.common.io.StreamUtils, var3702=$r3, var2797=java.nio.charset.Charset, var1841=java.nio.charset.StandardCharsets, var2662=$r2}
; {java.io.InputStream=var3813, r1=var1891, $r0=var1372, org.apache.dubbo.common.io.StreamUtils=var2795, $r3=var3702, java.nio.charset.Charset=var2797, java.nio.charset.StandardCharsets=var1841, $r2=var2662}
;seq <java.lang.String: void <init>(byte[],java.nio.charset.Charset)>
;cnt {"<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>": 1}
;stmts r1 := @parameter0: java.io.InputStream;	$r0 = new java.lang.String;	$r3 = staticinvoke <org.apache.dubbo.common.io.StreamUtils: byte[] readBytes(java.io.InputStream)>(r1);	$r2 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset UTF_8>;	specialinvoke $r0.<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>($r3, $r2);	return $r0
;block_num 1