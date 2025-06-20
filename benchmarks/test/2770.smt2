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

(declare-sort var1331 0)
(declare-sort var1427 0)
(declare-sort var2404 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun var2404_readBytes/1188925698 (var1331) (Array Int Int))
(declare-fun <init>/-2015205558 (String (Array Int Int) var1427) void)
(declare-const null-var1331 var1331)
(declare-const null-var1427 var1427)
(declare-const var218 var1331) ; Statement: r1 := @parameter0: java.io.InputStream 
(assert (not (= var218 null-var1331)))
(declare-const var1104 var1427) ; Statement: r2 := @parameter1: java.nio.charset.Charset 
(assert (not (= var1104 null-var1427)))
(define-const var1424 String String-init) ; Statement: $r0 = new java.lang.String 
(define-const var316 (Array Int Int) (var2404_readBytes/1188925698 var218)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.io.StreamUtils: byte[] readBytes(java.io.InputStream)>(r1) 
(assert true)
;(assert (<init>/-2015205558 var1424 var316 var1104)) ; Statement: specialinvoke $r0.<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>($r3, r2) 

(declare-const var1424!1 String)
(declare-const var316!1 (Array Int Int))
(declare-const var1104!1 var1427)
 ; Statement: return $r0 
(check-sat)
; {String-init=([], java.lang.String), var2404_readBytes/1188925698=([java.io.InputStream], byte[]), <init>/-2015205558=([java.lang.String, byte[], java.nio.charset.Charset], void)}
; {var1331=java.io.InputStream, var218=r1, var1427=java.nio.charset.Charset, var1104=r2, var1424=$r0, var2404=org.apache.dubbo.common.io.StreamUtils, var316=$r3}
; {java.io.InputStream=var1331, r1=var218, java.nio.charset.Charset=var1427, r2=var1104, $r0=var1424, org.apache.dubbo.common.io.StreamUtils=var2404, $r3=var316}
;seq <java.lang.String: void <init>(byte[],java.nio.charset.Charset)>
;cnt {"<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>": 1}
;stmts r1 := @parameter0: java.io.InputStream;	r2 := @parameter1: java.nio.charset.Charset;	$r0 = new java.lang.String;	$r3 = staticinvoke <org.apache.dubbo.common.io.StreamUtils: byte[] readBytes(java.io.InputStream)>(r1);	specialinvoke $r0.<java.lang.String: void <init>(byte[],java.nio.charset.Charset)>($r3, r2);	return $r0
;block_num 1