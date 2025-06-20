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

(declare-sort var900 0)
(declare-sort var716 0)
(declare-sort var538 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun var900-init () var900)
(declare-fun <init>/-2175807 (var900) void)
(declare-fun cast-from-var900-to-var716 (var900) var716)
(declare-fun var538-init () var538)
(declare-fun <init>/-28240458 (var538) void)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(define-const var1586 (Array Int Int) arr-Int-init) ; Statement: $r0 = newarray (char)[16] 
(declare-const var1586!1 (Array Int Int))
(assert (not (= var1586!1 null-__Array__Int__Int__)))
(assert (= (select var1586!1 0) 48)) ; Statement: $r0[0] = 48 
(declare-const var1586!2 (Array Int Int))
(assert (not (= var1586!2 null-__Array__Int__Int__)))
(assert (= (select var1586!2 1) 49)) ; Statement: $r0[1] = 49 
(declare-const var1586!3 (Array Int Int))
(assert (not (= var1586!3 null-__Array__Int__Int__)))
(assert (= (select var1586!3 2) 50)) ; Statement: $r0[2] = 50 
(declare-const var1586!4 (Array Int Int))
(assert (not (= var1586!4 null-__Array__Int__Int__)))
(assert (= (select var1586!4 3) 51)) ; Statement: $r0[3] = 51 
(declare-const var1586!5 (Array Int Int))
(assert (not (= var1586!5 null-__Array__Int__Int__)))
(assert (= (select var1586!5 4) 52)) ; Statement: $r0[4] = 52 
(declare-const var1586!6 (Array Int Int))
(assert (not (= var1586!6 null-__Array__Int__Int__)))
(assert (= (select var1586!6 5) 53)) ; Statement: $r0[5] = 53 
(declare-const var1586!7 (Array Int Int))
(assert (not (= var1586!7 null-__Array__Int__Int__)))
(assert (= (select var1586!7 6) 54)) ; Statement: $r0[6] = 54 
(declare-const var1586!8 (Array Int Int))
(assert (not (= var1586!8 null-__Array__Int__Int__)))
(assert (= (select var1586!8 7) 55)) ; Statement: $r0[7] = 55 
(declare-const var1586!9 (Array Int Int))
(assert (not (= var1586!9 null-__Array__Int__Int__)))
(assert (= (select var1586!9 8) 56)) ; Statement: $r0[8] = 56 
(declare-const var1586!10 (Array Int Int))
(assert (not (= var1586!10 null-__Array__Int__Int__)))
(assert (= (select var1586!10 9) 57)) ; Statement: $r0[9] = 57 
(declare-const var1586!11 (Array Int Int))
(assert (not (= var1586!11 null-__Array__Int__Int__)))
(assert (= (select var1586!11 10) 97)) ; Statement: $r0[10] = 97 
(declare-const var1586!12 (Array Int Int))
(assert (not (= var1586!12 null-__Array__Int__Int__)))
(assert (= (select var1586!12 11) 98)) ; Statement: $r0[11] = 98 
(declare-const var1586!13 (Array Int Int))
(assert (not (= var1586!13 null-__Array__Int__Int__)))
(assert (= (select var1586!13 12) 99)) ; Statement: $r0[12] = 99 
(declare-const var1586!14 (Array Int Int))
(assert (not (= var1586!14 null-__Array__Int__Int__)))
(assert (= (select var1586!14 13) 100)) ; Statement: $r0[13] = 100 
(declare-const var1586!15 (Array Int Int))
(assert (not (= var1586!15 null-__Array__Int__Int__)))
(assert (= (select var1586!15 14) 101)) ; Statement: $r0[14] = 101 
(declare-const var1586!16 (Array Int Int))
(assert (not (= var1586!16 null-__Array__Int__Int__)))
(assert (= (select var1586!16 15) 102)) ; Statement: $r0[15] = 102 
(define-const var1588 (Array Int Int) var1586!16) ; Statement: <org.apache.dubbo.common.io.Bytes: char[] BASE16> = $r0 
(define-const var1695 String "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=") ; Statement: $r1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=" 
(assert true)
(define-const var195 (Array Int Int) (toCharArray/415275702 var1695)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: char[] toCharArray()>() 
(define-const var2808 (Array Int Int) var195) ; Statement: <org.apache.dubbo.common.io.Bytes: char[] BASE64> = $r2 
(define-const var1348 var900 var900-init) ; Statement: $r3 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1348)) ; Statement: specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1348!1 var900)
(define-const var3707 var716 (cast-from-var900-to-var716 var1348!1)) ; Statement: <org.apache.dubbo.common.io.Bytes: java.util.Map DECODE_TABLE_MAP> = $r3 
(define-const var236 var538 var538-init) ; Statement: $r4 = new java.lang.ThreadLocal 
(assert true)
;(assert (<init>/-28240458 var236)) ; Statement: specialinvoke $r4.<java.lang.ThreadLocal: void <init>()>() 

(declare-const var236!1 var538)
(define-const var3286 var538 var236!1) ; Statement: <org.apache.dubbo.common.io.Bytes: java.lang.ThreadLocal MD> = $r4 
 ; Statement: return 
(check-sat)
; {arr-Int-init=([], char[]), toCharArray/415275702=([java.lang.String], char[]), var900-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var900-to-var716=([java.util.concurrent.ConcurrentHashMap], java.util.Map), var538-init=([], java.lang.ThreadLocal), <init>/-28240458=([java.lang.ThreadLocal], void)}
; {var1586=$r0, var1588=<org.apache.dubbo.common.io.Bytes: char[] BASE16>, var1695=$r1, var195=$r2, var2808=<org.apache.dubbo.common.io.Bytes: char[] BASE64>, var900=java.util.concurrent.ConcurrentHashMap, var1348=$r3, var716=java.util.Map, var3707=<org.apache.dubbo.common.io.Bytes: java.util.Map DECODE_TABLE_MAP>, var538=java.lang.ThreadLocal, var236=$r4, var3286=<org.apache.dubbo.common.io.Bytes: java.lang.ThreadLocal MD>}
; {$r0=var1586, <org.apache.dubbo.common.io.Bytes: char[] BASE16>=var1588, $r1=var1695, $r2=var195, <org.apache.dubbo.common.io.Bytes: char[] BASE64>=var2808, java.util.concurrent.ConcurrentHashMap=var900, $r3=var1348, java.util.Map=var716, <org.apache.dubbo.common.io.Bytes: java.util.Map DECODE_TABLE_MAP>=var3707, java.lang.ThreadLocal=var538, $r4=var236, <org.apache.dubbo.common.io.Bytes: java.lang.ThreadLocal MD>=var3286}
;seq <java.lang.String: char[] toCharArray()>
;cnt {"<java.lang.String: char[] toCharArray()>": 1}
;stmts $r0 = newarray (char)[16];	$r0[0] = 48;	$r0[1] = 49;	$r0[2] = 50;	$r0[3] = 51;	$r0[4] = 52;	$r0[5] = 53;	$r0[6] = 54;	$r0[7] = 55;	$r0[8] = 56;	$r0[9] = 57;	$r0[10] = 97;	$r0[11] = 98;	$r0[12] = 99;	$r0[13] = 100;	$r0[14] = 101;	$r0[15] = 102;	<org.apache.dubbo.common.io.Bytes: char[] BASE16> = $r0;	$r1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";	$r2 = virtualinvoke $r1.<java.lang.String: char[] toCharArray()>();	<org.apache.dubbo.common.io.Bytes: char[] BASE64> = $r2;	$r3 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	<org.apache.dubbo.common.io.Bytes: java.util.Map DECODE_TABLE_MAP> = $r3;	$r4 = new java.lang.ThreadLocal;	specialinvoke $r4.<java.lang.ThreadLocal: void <init>()>();	<org.apache.dubbo.common.io.Bytes: java.lang.ThreadLocal MD> = $r4;	return
;block_num 1