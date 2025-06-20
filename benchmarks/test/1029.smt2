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

(declare-sort var667 0)
(declare-sort var3968 0)
(declare-sort var2004 0)
(declare-sort var1444 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-fun var2004_parseDecodedParams/-839888360 (String Int) var3968)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var2004_parseURLBody/46347189 (String String var3968) var1444)
(declare-const null-String String)
(declare-const null-var3968 var3968)
(declare-const var1990 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1990 null-String)))
(define-const var3402 var3968 null-var3968) ; Statement: r3 = null 
(assert true)
(define-const var3251 Int (indexOf/-1037706067 var1990 63)) ; Statement: i1 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(63) 
 ; Statement: if i1 < 0 goto i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (< var3251 0))) ; Negate: Cond: i1 < 0  
(define-const var1829 Int (+ var3251 1)) ; Statement: $i0 = i1 + 1 
(define-const var3402!1 var3968 (var2004_parseDecodedParams/-839888360 var1990 var1829)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.util.Map parseDecodedParams(java.lang.String,int)>(r0, $i0) 
 ; Statement: goto [?= $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i1)] 
(assert true) ; Non Conditional
(assert (and true (and (>= 0 0) (>= (str.len var1990) var3251) (>= var3251 0))))
(define-const var2650 String (substring/-1240304868 var1990 0 var3251)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i1) 
(define-const var1175 var1444 (var2004_parseURLBody/46347189 var1990 var2650 var3402!1)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.URLStrParser: org.apache.dubbo.common.URL parseURLBody(java.lang.String,java.lang.String,java.util.Map)>(r0, $r2, r3) 
 ; Statement: return $r1 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), var2004_parseDecodedParams/-839888360=([java.lang.String, int], java.util.Map), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var2004_parseURLBody/46347189=([java.lang.String, java.lang.String, java.util.Map], org.apache.dubbo.common.URL)}
; {var1990=r0, var667=null_type, var3968=java.util.Map, var3402=r3, var3251=i1, var1829=$i0, var2004=org.apache.dubbo.common.URLStrParser, var2650=$r2, var1444=org.apache.dubbo.common.URL, var1175=$r1}
; {r0=var1990, null_type=var667, java.util.Map=var3968, r3=var3402, i1=var3251, $i0=var1829, org.apache.dubbo.common.URLStrParser=var2004, $r2=var2650, org.apache.dubbo.common.URL=var1444, $r1=var1175}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 = null;	i1 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(63);	if i1 < 0 goto i1 = virtualinvoke r0.<java.lang.String: int length()>();	$i0 = i1 + 1;	r3 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.util.Map parseDecodedParams(java.lang.String,int)>(r0, $i0);	goto [?= $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i1)];	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i1);	$r1 = staticinvoke <org.apache.dubbo.common.URLStrParser: org.apache.dubbo.common.URL parseURLBody(java.lang.String,java.lang.String,java.util.Map)>(r0, $r2, r3);	return $r1
;block_num 3