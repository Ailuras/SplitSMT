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

(declare-sort var1925 0)
(declare-sort var1926 0)
(declare-sort var2581 0)
(declare-sort var562 0)
(declare-sort var3993 0)
(declare-sort var1604 0)
(declare-sort var1027 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toUpperCase/1156088314 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun get/-896773187 (var2581) var3993)
(declare-fun cast-from-var3993-to-var1604 (var3993) var1604)
(declare-fun var562_decodeComponent/1918253631 (String Int Int Bool var1604) String)
(declare-fun var562_parseURLBody/46347189 (String String var1926) var1027)
(declare-const null-String String)
(declare-const null-var1926 var1926)
(declare-const var562-DECODE_TEMP_BUF var2581)
(declare-const var2676 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2676 null-String)))
(define-const var1176 var1926 null-var1926) ; Statement: r7 = null 
(assert true)
(define-const var2451 String (toUpperCase/1156088314 var2676)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String toUpperCase()>() 
(assert true)
(define-const var299 Int (indexOf/-1209756239 var2451 "%3F")) ; Statement: i1 = virtualinvoke $r1.<java.lang.String: int indexOf(java.lang.String)>("%3F") 
 ; Statement: if i1 < 0 goto i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (< var299 0)) ; Cond: i1 < 0 
(assert true)
(define-const var299!1 Int (length/-134980193 var2676)) ; Statement: i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var2521 var2581 var562-DECODE_TEMP_BUF) ; Statement: $r2 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF> 
(assert true)
(define-const var1146 var3993 (get/-896773187 var2521)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.ThreadLocal: java.lang.Object get()>() 
(define-const var227 var1604 (cast-from-var3993-to-var1604 var1146)) ; Statement: $r4 = (org.apache.dubbo.common.URLStrParser$TempBuf) $r3 
(define-const var978 String (var562_decodeComponent/1918253631 var2676 0 var299!1 (ite (= 1 0) true false) var227)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.lang.String decodeComponent(java.lang.String,int,int,boolean,org.apache.dubbo.common.URLStrParser$TempBuf)>(r0, 0, i1, 0, $r4) 
(define-const var3655 var1027 (var562_parseURLBody/46347189 var2676 var978 var1176)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.URLStrParser: org.apache.dubbo.common.URL parseURLBody(java.lang.String,java.lang.String,java.util.Map)>(r0, $r6, r7) 
 ; Statement: return $r5 
(check-sat)
; {toUpperCase/1156088314=([java.lang.String], java.lang.String), indexOf/-1209756239=([java.lang.String, java.lang.String], int), length/-134980193=([java.lang.String], int), get/-896773187=([java.lang.ThreadLocal], java.lang.Object), cast-from-var3993-to-var1604=([java.lang.Object], org.apache.dubbo.common.URLStrParser$TempBuf), var562_decodeComponent/1918253631=([java.lang.String, int, int, boolean, org.apache.dubbo.common.URLStrParser$TempBuf], java.lang.String), var562_parseURLBody/46347189=([java.lang.String, java.lang.String, java.util.Map], org.apache.dubbo.common.URL)}
; {var2676=r0, var1925=null_type, var1926=java.util.Map, var1176=r7, var2451=$r1, var299=i1, var2581=java.lang.ThreadLocal, var562=org.apache.dubbo.common.URLStrParser, var2521=$r2, var3993=java.lang.Object, var1146=$r3, var1604=org.apache.dubbo.common.URLStrParser$TempBuf, var227=$r4, var978=$r6, var1027=org.apache.dubbo.common.URL, var3655=$r5}
; {r0=var2676, null_type=var1925, java.util.Map=var1926, r7=var1176, $r1=var2451, i1=var299, java.lang.ThreadLocal=var2581, org.apache.dubbo.common.URLStrParser=var562, $r2=var2521, java.lang.Object=var3993, $r3=var1146, org.apache.dubbo.common.URLStrParser$TempBuf=var1604, $r4=var227, $r6=var978, org.apache.dubbo.common.URL=var1027, $r5=var3655}
;seq <java.lang.String: java.lang.String toUpperCase()>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String toUpperCase()>": 1,"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r7 = null;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String toUpperCase()>();	i1 = virtualinvoke $r1.<java.lang.String: int indexOf(java.lang.String)>("%3F");	if i1 < 0 goto i1 = virtualinvoke r0.<java.lang.String: int length()>();	i1 = virtualinvoke r0.<java.lang.String: int length()>();	$r2 = <org.apache.dubbo.common.URLStrParser: java.lang.ThreadLocal DECODE_TEMP_BUF>;	$r3 = virtualinvoke $r2.<java.lang.ThreadLocal: java.lang.Object get()>();	$r4 = (org.apache.dubbo.common.URLStrParser$TempBuf) $r3;	$r6 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.lang.String decodeComponent(java.lang.String,int,int,boolean,org.apache.dubbo.common.URLStrParser$TempBuf)>(r0, 0, i1, 0, $r4);	$r5 = staticinvoke <org.apache.dubbo.common.URLStrParser: org.apache.dubbo.common.URL parseURLBody(java.lang.String,java.lang.String,java.util.Map)>(r0, $r6, r7);	return $r5
;block_num 3