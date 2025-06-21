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

(declare-sort var1694 0)
(declare-sort var3422 0)
(declare-sort var2306 0)
(declare-sort var134 0)
(declare-sort var1583 0)
(declare-sort var840 0)
(declare-sort var2120 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toUpperCase/1156088314 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(declare-fun var2306_parseEncodedParams/-540129216 (String Int) var3422)
(declare-fun get/-896773187 (var134) var1583)
(declare-fun cast-from-var1583-to-var840 (var1583) var840)
(declare-fun var2306_decodeComponent/1918253631 (String Int Int Bool var840) String)
(declare-fun var2306_parseURLBody/46347189 (String String var3422) var2120)
(declare-const null-String String)
(declare-const null-var3422 var3422)
(declare-const var2306-DECODE_TEMP_BUF var134)
(declare-const var3967 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3967 null-String)))
(define-const var34 var3422 null-var3422) ; Statement: r7 = null 
(assert true)
(define-const var812 String (toUpperCase/1156088314 var3967)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var1556 Int (indexOf/-1209756239 var812 "%3F")) ; Statement: i1 = virtualinvoke $r1.<java.lang.String: int indexOf(java.lang.String)>("%3F") 
 ; Statement: if i1 < 0 goto i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (< var1556 0))) ; Negate: Cond: i1 < 0  
(define-const var2929 Int (+ var1556 3)) ; Statement: $i0 = i1 + 3 
(define-const var34!1 var3422 (var2306_parseEncodedParams/-540129216 var3967 var2929)) ; Statement: r7 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.util.Map parseEncodedParams(java.lang.String,int)>(r0, $i0) 
 ; Statement: goto [?= $r2 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF>] 
(assert true) ; Non Conditional
(define-const var3178 var134 var2306-DECODE_TEMP_BUF) ; Statement: $r2 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF> 
(assert true)
(define-const var3179 var1583 (get/-896773187 var3178)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.ThreadLocal: java.lang.Object get()>() 
(define-const var2128 var840 (cast-from-var1583-to-var840 var3179)) ; Statement: $r4 = (org.apache.dubbo.common.URLStrParser$TempBuf) $r3 
(define-const var2582 String (var2306_decodeComponent/1918253631 var3967 0 var1556 (ite (= 1 0) true false) var2128)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.lang.String decodeComponent(java.lang.String,int,int,boolean,org.apache.dubbo.common.URLStrParser$TempBuf)>(r0, 0, i1, 0, $r4) 
(define-const var2884 var2120 (var2306_parseURLBody/46347189 var3967 var2582 var34!1)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.URLStrParser: org.apache.dubbo.common.URL parseURLBody(java.lang.String,java.lang.String,java.util.Map)>(r0, $r6, r7) 
 ; Statement: return $r5 
(check-sat)
; {toUpperCase/1156088314=([java.lang.String], java.lang.String), indexOf/-1209756239=([java.lang.String, java.lang.String], int), var2306_parseEncodedParams/-540129216=([java.lang.String, int], java.util.Map), get/-896773187=([java.lang.ThreadLocal], java.lang.Object), cast-from-var1583-to-var840=([java.lang.Object], org.apache.dubbo.common.URLStrParser$TempBuf), var2306_decodeComponent/1918253631=([java.lang.String, int, int, boolean, org.apache.dubbo.common.URLStrParser$TempBuf], java.lang.String), var2306_parseURLBody/46347189=([java.lang.String, java.lang.String, java.util.Map], org.apache.dubbo.common.URL)}
; {var3967=r0, var1694=null_type, var3422=java.util.Map, var34=r7, var812=$r1, var1556=i1, var2929=$i0, var2306=org.apache.dubbo.common.URLStrParser, var134=java.lang.ThreadLocal, var3178=$r2, var1583=java.lang.Object, var3179=$r3, var840=org.apache.dubbo.common.URLStrParser$TempBuf, var2128=$r4, var2582=$r6, var2120=org.apache.dubbo.common.URL, var2884=$r5}
; {r0=var3967, null_type=var1694, java.util.Map=var3422, r7=var34, $r1=var812, i1=var1556, $i0=var2929, org.apache.dubbo.common.URLStrParser=var2306, java.lang.ThreadLocal=var134, $r2=var3178, java.lang.Object=var1583, $r3=var3179, org.apache.dubbo.common.URLStrParser$TempBuf=var840, $r4=var2128, $r6=var2582, org.apache.dubbo.common.URL=var2120, $r5=var2884}
;seq <java.lang.String: java.lang.String toUpperCase()>;	<java.lang.String: int indexOf(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.String: int indexOf(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r7 = null;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String toUpperCase()>();	i1 = virtualinvoke $r1.<java.lang.String: int indexOf(java.lang.String)>("%3F");	if i1 < 0 goto i1 = virtualinvoke r0.<java.lang.String: int length()>();	$i0 = i1 + 3;	r7 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.util.Map parseEncodedParams(java.lang.String,int)>(r0, $i0);	goto [?= $r2 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF>];	$r2 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF>;	$r3 = virtualinvoke $r2.<java.lang.ThreadLocal: java.lang.Object get()>();	$r4 = (org.apache.dubbo.common.URLStrParser$TempBuf) $r3;	$r6 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.lang.String decodeComponent(java.lang.String,int,int,boolean,org.apache.dubbo.common.URLStrParser$TempBuf)>(r0, 0, i1, 0, $r4);	$r5 = staticinvoke <org.apache.dubbo.common.URLStrParser: org.apache.dubbo.common.URL parseURLBody(java.lang.String,java.lang.String,java.util.Map)>(r0, $r6, r7);	return $r5
;block_num 3